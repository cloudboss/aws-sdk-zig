const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchGetTaskIdentifier = @import("batch_get_task_identifier.zig").BatchGetTaskIdentifier;
const BatchGetTaskError = @import("batch_get_task_error.zig").BatchGetTaskError;
const BatchGetTaskItem = @import("batch_get_task_item.zig").BatchGetTaskItem;

pub const BatchGetTaskInput = struct {
    /// The list of task identifiers to retrieve. You can specify up to 100
    /// identifiers per request.
    identifiers: []const BatchGetTaskIdentifier,

    pub const json_field_names = .{
        .identifiers = "identifiers",
    };
};

pub const BatchGetTaskOutput = struct {
    /// A list of errors for tasks that could not be retrieved.
    errors: ?[]const BatchGetTaskError = null,

    /// A list of tasks that were successfully retrieved.
    tasks: ?[]const BatchGetTaskItem = null,

    pub const json_field_names = .{
        .errors = "errors",
        .tasks = "tasks",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetTaskInput, options: CallOptions) !BatchGetTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "deadline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("deadline", "deadline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2023-10-12/batch-get-task";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"identifiers\":");
    try aws.json.writeValue(@TypeOf(input.identifiers), input.identifiers, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetTaskOutput {
    const result: BatchGetTaskOutput = try aws.json.parseJsonObject(
        BatchGetTaskOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
