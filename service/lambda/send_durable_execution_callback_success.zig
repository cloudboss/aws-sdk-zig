const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SendDurableExecutionCallbackSuccessInput = struct {
    /// The unique identifier for the callback operation.
    callback_id: []const u8,

    /// The result data from the successful callback operation. Maximum size is 256
    /// KB.
    result: ?[]const u8 = null,

    pub const json_field_names = .{
        .callback_id = "CallbackId",
        .result = "Result",
    };
};

pub const SendDurableExecutionCallbackSuccessOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendDurableExecutionCallbackSuccessInput, options: CallOptions) !SendDurableExecutionCallbackSuccessOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SendDurableExecutionCallbackSuccessInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2025-12-01/durable-execution-callbacks/");
    try path_buf.appendSlice(allocator, input.callback_id);
    try path_buf.appendSlice(allocator, "/succeed");
    const path = try path_buf.toOwnedSlice(allocator);

    const body = input.result orelse "";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendDurableExecutionCallbackSuccessOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: SendDurableExecutionCallbackSuccessOutput = .{};

    return result;
}
