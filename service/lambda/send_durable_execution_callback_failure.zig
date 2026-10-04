const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ErrorObject = @import("error_object.zig").ErrorObject;

pub const SendDurableExecutionCallbackFailureInput = struct {
    /// The unique identifier for the callback operation.
    callback_id: []const u8,

    /// Error details describing why the callback operation failed.
    @"error": ?ErrorObject = null,

    pub const json_field_names = .{
        .callback_id = "CallbackId",
        .@"error" = "Error",
    };
};

pub const SendDurableExecutionCallbackFailureOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendDurableExecutionCallbackFailureInput, options: CallOptions) !SendDurableExecutionCallbackFailureOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SendDurableExecutionCallbackFailureInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2025-12-01/durable-execution-callbacks/");
    try path_buf.appendSlice(allocator, input.callback_id);
    try path_buf.appendSlice(allocator, "/fail");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = if (input.@"error") |v| try aws.json.jsonStringify(v, allocator) else null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendDurableExecutionCallbackFailureOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: SendDurableExecutionCallbackFailureOutput = .{};

    return result;
}
