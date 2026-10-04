const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProspectingTaskStatus = @import("prospecting_task_status.zig").ProspectingTaskStatus;

pub const StartProspectingFromEngagementTaskInput = struct {
    /// Specifies the catalog in which the task is initiated. Specify `AWS` for
    /// production environments and `Sandbox` for testing and development purposes.
    catalog: []const u8,

    /// A unique, case-sensitive identifier provided by the client to ensure
    /// idempotency. Making the same request with the same `ClientToken` returns the
    /// same response without creating a duplicate task.
    client_token: []const u8,

    /// The list of engagement identifiers to include in this prospecting task. Each
    /// identifier must correspond to an existing engagement in the specified
    /// catalog. Maximum of 100 identifiers per task.
    identifiers: []const []const u8,

    /// A descriptive name for the task. This name helps identify the task in list
    /// and get operations. The name must contain 1 to 128 characters.
    task_name: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .client_token = "ClientToken",
        .identifiers = "Identifiers",
        .task_name = "TaskName",
    };
};

pub const StartProspectingFromEngagementTaskOutput = struct {
    /// The list of engagement identifiers that were accepted into the task queue
    /// for processing. This list matches the identifiers provided in the request.
    identifiers: ?[]const []const u8 = null,

    /// A message providing additional context about the task's current state. When
    /// the task fails, this field contains a detailed description of the failure
    /// and suggested recovery steps. This field is only populated for tasks in a
    /// failed state.
    message: ?[]const u8 = null,

    /// An enumerated code identifying the reason for task failure. This field is
    /// only populated when the task has failed. Use the corresponding `Message`
    /// field for a human-readable description of the failure.
    reason_code: ?[]const u8 = null,

    /// The timestamp indicating when the task was initiated. The format follows ISO
    /// 8601 date-time notation.
    start_time: i64,

    /// The Amazon Resource Name (ARN) of the task. The ARN uniquely identifies the
    /// task across AWS and can be used for resource-level IAM policies.
    task_arn: ?[]const u8 = null,

    /// The unique identifier assigned to this task. Use this identifier with
    /// `GetProspectingFromEngagementTask` to retrieve task details and check
    /// status.
    task_id: ?[]const u8 = null,

    /// The task name from the request.
    task_name: []const u8,

    /// The current status of the task. Possible values: `PENDING` (waiting to run),
    /// `IN_PROGRESS` (actively processing), `COMPLETED` (successfully processed),
    /// and `FAILED` (unrecoverable error).
    task_status: ProspectingTaskStatus,

    pub const json_field_names = .{
        .identifiers = "Identifiers",
        .message = "Message",
        .reason_code = "ReasonCode",
        .start_time = "StartTime",
        .task_arn = "TaskArn",
        .task_id = "TaskId",
        .task_name = "TaskName",
        .task_status = "TaskStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartProspectingFromEngagementTaskInput, options: CallOptions) !StartProspectingFromEngagementTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartProspectingFromEngagementTaskInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.StartProspectingFromEngagementTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartProspectingFromEngagementTaskOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(StartProspectingFromEngagementTaskOutput, body, allocator);
}
