const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecursiveLoop = @import("recursive_loop.zig").RecursiveLoop;

pub const GetFunctionRecursionConfigInput = struct {
    /// The name of the function.
    function_name: []const u8,

    pub const json_field_names = .{
        .function_name = "FunctionName",
    };
};

pub const GetFunctionRecursionConfigOutput = struct {
    /// If your function's recursive loop detection configuration is `Allow`, Lambda
    /// doesn't take any action when it detects your function being invoked as part
    /// of a recursive loop.
    ///
    /// If your function's recursive loop detection configuration is `Terminate`,
    /// Lambda stops your function being invoked and notifies you when it detects
    /// your function being invoked as part of a recursive loop.
    ///
    /// By default, Lambda sets your function's configuration to `Terminate`. You
    /// can update this configuration using the PutFunctionRecursionConfig action.
    recursive_loop: ?RecursiveLoop = null,

    pub const json_field_names = .{
        .recursive_loop = "RecursiveLoop",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFunctionRecursionConfigInput, options: CallOptions) !GetFunctionRecursionConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFunctionRecursionConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2024-08-31/functions/");
    try path_buf.appendSlice(allocator, input.function_name);
    try path_buf.appendSlice(allocator, "/recursion-config");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFunctionRecursionConfigOutput {
    const result: GetFunctionRecursionConfigOutput = try aws.json.parseJsonObject(
        GetFunctionRecursionConfigOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
