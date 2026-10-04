const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Runbook = @import("runbook.zig").Runbook;
const Tag = @import("tag.zig").Tag;

pub const StartChangeRequestExecutionInput = struct {
    /// Indicates whether the change request can be approved automatically without
    /// the need for
    /// manual approvals.
    ///
    /// If `AutoApprovable` is enabled in a change template, then setting
    /// `AutoApprove` to `true` in `StartChangeRequestExecution`
    /// creates a change request that bypasses approver review.
    ///
    /// Change Calendar restrictions are not bypassed in this scenario. If the state
    /// of an
    /// associated calendar is `CLOSED`, change freeze approvers must still grant
    /// permission
    /// for this change request to run. If they don't, the change won't be processed
    /// until the calendar
    /// state is again `OPEN`.
    auto_approve: ?bool = null,

    /// User-provided details about the change. If no details are provided, content
    /// specified in the
    /// **Template information** section of the associated change template
    /// is added.
    change_details: ?[]const u8 = null,

    /// The name of the change request associated with the runbook workflow to be
    /// run.
    change_request_name: ?[]const u8 = null,

    /// The user-provided idempotency token. The token must be unique, is case
    /// insensitive, enforces
    /// the UUID format, and can't be reused.
    client_token: ?[]const u8 = null,

    /// The name of the change template document to run during the runbook workflow.
    document_name: []const u8,

    /// The version of the change template document to run during the runbook
    /// workflow.
    document_version: ?[]const u8 = null,

    /// A key-value map of parameters that match the declared parameters in the
    /// change template
    /// document.
    parameters: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// Information about the Automation runbooks that are run during the runbook
    /// workflow.
    ///
    /// The Automation runbooks specified for the runbook workflow can't run until
    /// all required
    /// approvals for the change request have been received.
    runbooks: []const Runbook,

    /// The time that the requester expects the runbook workflow related to the
    /// change request to
    /// complete. The time is an estimate only that the requester provides for
    /// reviewers.
    scheduled_end_time: ?i64 = null,

    /// The date and time specified in the change request to run the Automation
    /// runbooks.
    ///
    /// The Automation runbooks specified for the runbook workflow can't run until
    /// all required
    /// approvals for the change request have been received.
    scheduled_time: ?i64 = null,

    /// Optional metadata that you assign to a resource. You can specify a maximum
    /// of five tags for
    /// a change request. Tags enable you to categorize a resource in different
    /// ways, such as by
    /// purpose, owner, or environment. For example, you might want to tag a change
    /// request to identify
    /// an environment or target Amazon Web Services Region. In this case, you could
    /// specify the following key-value
    /// pairs:
    ///
    /// * `Key=Environment,Value=Production`
    ///
    /// * `Key=Region,Value=us-east-2`
    ///
    /// The `Array Members` maximum value is reported as 1000. This number includes
    /// capacity reserved for internal operations. When calling the
    /// `StartChangeRequestExecution` action, you can specify a maximum of 5 tags.
    /// You can,
    /// however, use the AddTagsToResource action to add up to a total of 50 tags to
    /// an existing change request configuration.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .auto_approve = "AutoApprove",
        .change_details = "ChangeDetails",
        .change_request_name = "ChangeRequestName",
        .client_token = "ClientToken",
        .document_name = "DocumentName",
        .document_version = "DocumentVersion",
        .parameters = "Parameters",
        .runbooks = "Runbooks",
        .scheduled_end_time = "ScheduledEndTime",
        .scheduled_time = "ScheduledTime",
        .tags = "Tags",
    };
};

pub const StartChangeRequestExecutionOutput = struct {
    /// The unique ID of a runbook workflow operation. (A runbook workflow is a type
    /// of Automation
    /// operation.)
    automation_execution_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .automation_execution_id = "AutomationExecutionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartChangeRequestExecutionInput, options: CallOptions) !StartChangeRequestExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: StartChangeRequestExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.StartChangeRequestExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartChangeRequestExecutionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartChangeRequestExecutionOutput, body, allocator);
}
