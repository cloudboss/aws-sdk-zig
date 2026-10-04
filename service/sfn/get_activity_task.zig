const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetActivityTaskInput = struct {
    /// The Amazon Resource Name (ARN) of the activity to retrieve tasks from
    /// (assigned when you create the task
    /// using CreateActivity.)
    activity_arn: []const u8,

    /// You can provide an arbitrary name in order to identify the worker that the
    /// task is
    /// assigned to. This name is used when it is logged in the execution history.
    worker_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .activity_arn = "activityArn",
        .worker_name = "workerName",
    };
};

pub const GetActivityTaskOutput = struct {
    /// The string that contains the JSON input data for the task. Length
    /// constraints apply to the payload size, and are expressed as bytes in UTF-8
    /// encoding.
    input: ?[]const u8 = null,

    /// A token that identifies the scheduled task. This token must be copied and
    /// included in
    /// subsequent calls to SendTaskHeartbeat, SendTaskSuccess or
    /// SendTaskFailure in order to report the progress or completion of the
    /// task.
    task_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .input = "input",
        .task_token = "taskToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetActivityTaskInput, options: CallOptions) !GetActivityTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "states", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetActivityTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("states", "SFN", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSStepFunctions.GetActivityTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetActivityTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetActivityTaskOutput, body, allocator);
}
