const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DetectMitigationActionsTaskSummary = @import("detect_mitigation_actions_task_summary.zig").DetectMitigationActionsTaskSummary;

pub const DescribeDetectMitigationActionsTaskInput = struct {
    /// The unique identifier of the task.
    task_id: []const u8,

    pub const json_field_names = .{
        .task_id = "taskId",
    };
};

pub const DescribeDetectMitigationActionsTaskOutput = struct {
    /// The description of a task.
    task_summary: ?DetectMitigationActionsTaskSummary = null,

    pub const json_field_names = .{
        .task_summary = "taskSummary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDetectMitigationActionsTaskInput, options: CallOptions) !DescribeDetectMitigationActionsTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDetectMitigationActionsTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/detect/mitigationactions/tasks/");
    try path_buf.appendSlice(allocator, input.task_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDetectMitigationActionsTaskOutput {
    const result: DescribeDetectMitigationActionsTaskOutput = try aws.json.parseJsonObject(
        DescribeDetectMitigationActionsTaskOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
