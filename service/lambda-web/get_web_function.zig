const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FunctionState = @import("function_state.zig").FunctionState;

pub const GetWebFunctionInput = struct {
    /// The name of the web function to retrieve. You can specify the function name
    /// or the function ARN. The length constraint applies only to the full ARN. If
    /// you specify only the function name, it is limited to 64 characters in
    /// length.
    function_name: []const u8,

    pub const json_field_names = .{
        .function_name = "functionName",
    };
};

pub const GetWebFunctionOutput = struct {
    /// The date and time the web function was created.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the web function.
    function_arn: []const u8,

    /// The name of the web function.
    function_name: []const u8,

    /// The current state of the web function.
    state: FunctionState,

    /// The reason for the current state of the web function.
    state_reason: []const u8,

    /// The date and time the web function was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .function_arn = "functionArn",
        .function_name = "functionName",
        .state = "state",
        .state_reason = "stateReason",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWebFunctionInput, options: CallOptions) !GetWebFunctionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWebFunctionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda Web", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2025-03-07/web-functions/");
    try path_buf.appendSlice(allocator, input.function_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWebFunctionOutput {
    const result: GetWebFunctionOutput = try aws.json.parseJsonObject(
        GetWebFunctionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
