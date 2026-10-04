const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TaskDetails = @import("task_details.zig").TaskDetails;
const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const ProfileTaskStatus = @import("profile_task_status.zig").ProfileTaskStatus;

pub const StartProfileUpdateTaskInput = struct {
    /// The catalog identifier for the partner account.
    catalog: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The unique identifier of the partner account.
    identifier: []const u8,

    /// The details of the profile updates to be performed.
    task_details: TaskDetails,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .client_token = "ClientToken",
        .identifier = "Identifier",
        .task_details = "TaskDetails",
    };
};

pub const StartProfileUpdateTaskOutput = struct {
    /// The Amazon Resource Name (ARN) of the started profile update task.
    arn: []const u8,

    /// The catalog identifier for the partner account.
    catalog: []const u8,

    /// The timestamp when the profile update task ended (null for in-progress
    /// tasks).
    ended_at: ?i64 = null,

    /// A list of error details if any errors occurred during the profile update
    /// task.
    error_detail_list: ?[]const ErrorDetail = null,

    /// The unique identifier of the partner account.
    id: []const u8,

    /// The timestamp when the profile update task was started.
    started_at: i64,

    /// The current status of the profile update task (in progress).
    status: ProfileTaskStatus,

    /// The details of the profile update task that was started.
    task_details: ?TaskDetails = null,

    /// The unique identifier of the started profile update task.
    task_id: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .catalog = "Catalog",
        .ended_at = "EndedAt",
        .error_detail_list = "ErrorDetailList",
        .id = "Id",
        .started_at = "StartedAt",
        .status = "Status",
        .task_details = "TaskDetails",
        .task_id = "TaskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartProfileUpdateTaskInput, options: CallOptions) !StartProfileUpdateTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartProfileUpdateTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-account", "PartnerCentral Account", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralAccount.StartProfileUpdateTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartProfileUpdateTaskOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(StartProfileUpdateTaskOutput, body, allocator);
}
