const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AwsSubmission = @import("aws_submission.zig").AwsSubmission;
const Tag = @import("tag.zig").Tag;
const ReasonCode = @import("reason_code.zig").ReasonCode;
const TaskStatus = @import("task_status.zig").TaskStatus;

pub const StartEngagementFromOpportunityTaskInput = struct {
    aws_submission: AwsSubmission,

    /// Specifies the catalog in which the engagement is tracked. Acceptable values
    /// include `AWS` for production and `Sandbox` for testing environments.
    catalog: []const u8,

    /// A unique token provided by the client to help ensure the idempotency of the
    /// request. It helps prevent the same task from being performed multiple times.
    client_token: []const u8,

    /// The unique identifier of the opportunity from which the engagement task is
    /// to be initiated. This helps ensure that the task is applied to the correct
    /// opportunity.
    identifier: []const u8,

    /// A map of the key-value pairs of the tag or tags to assign.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .aws_submission = "AwsSubmission",
        .catalog = "Catalog",
        .client_token = "ClientToken",
        .identifier = "Identifier",
        .tags = "Tags",
    };
};

pub const StartEngagementFromOpportunityTaskOutput = struct {
    /// The identifier of the newly created Engagement. Only populated if TaskStatus
    /// is COMPLETE.
    engagement_id: ?[]const u8 = null,

    /// The identifier of the new Engagement invitation. Only populated if
    /// TaskStatus is COMPLETE.
    engagement_invitation_id: ?[]const u8 = null,

    /// If the task fails, this field contains a detailed message describing the
    /// failure and possible recovery steps.
    message: ?[]const u8 = null,

    /// Returns the original opportunity identifier passed in the request, which is
    /// the unique identifier for the opportunity created in the partner’s system.
    opportunity_id: ?[]const u8 = null,

    /// Indicates the reason for task failure using an enumerated code.
    reason_code: ?ReasonCode = null,

    /// The identifier of the resource snapshot job created to add the opportunity
    /// resource snapshot to the Engagement. Only populated if TaskStatus is
    /// COMPLETE
    resource_snapshot_job_id: ?[]const u8 = null,

    /// The timestamp indicating when the task was initiated. The format follows RFC
    /// 3339 section 5.6.
    start_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the task, used for tracking and managing
    /// the task within AWS.
    task_arn: ?[]const u8 = null,

    /// The unique identifier of the task, used to track the task’s progress. This
    /// value follows a specific pattern: `^oit-[0-9a-z]{13}$`.
    task_id: ?[]const u8 = null,

    /// Indicates the current status of the task. Valid values include
    /// `IN_PROGRESS`, `COMPLETE`, and `FAILED`.
    task_status: ?TaskStatus = null,

    pub const json_field_names = .{
        .engagement_id = "EngagementId",
        .engagement_invitation_id = "EngagementInvitationId",
        .message = "Message",
        .opportunity_id = "OpportunityId",
        .reason_code = "ReasonCode",
        .resource_snapshot_job_id = "ResourceSnapshotJobId",
        .start_time = "StartTime",
        .task_arn = "TaskArn",
        .task_id = "TaskId",
        .task_status = "TaskStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartEngagementFromOpportunityTaskInput, options: CallOptions) !StartEngagementFromOpportunityTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "partnercentral", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartEngagementFromOpportunityTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-selling", "PartnerCentral Selling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.StartEngagementFromOpportunityTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartEngagementFromOpportunityTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartEngagementFromOpportunityTaskOutput, body, allocator);
}
