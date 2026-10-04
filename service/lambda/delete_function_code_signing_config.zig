const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteFunctionCodeSigningConfigInput = struct {
    /// The name or ARN of the Lambda function. **Name formats**
    ///
    /// * **Function name** - `MyFunction`.
    /// * **Function ARN** -
    ///   `arn:aws:lambda:us-west-2:123456789012:function:MyFunction`.
    /// * **Partial ARN** - `123456789012:function:MyFunction`.
    ///
    /// The length constraint applies only to the full ARN. If you specify only the
    /// function name, it is limited to 64 characters in length.
    function_name: []const u8,

    pub const json_field_names = .{
        .function_name = "FunctionName",
    };
};

pub const DeleteFunctionCodeSigningConfigOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteFunctionCodeSigningConfigInput, options: CallOptions) !DeleteFunctionCodeSigningConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteFunctionCodeSigningConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2020-06-30/functions/");
    try path_buf.appendSlice(allocator, input.function_name);
    try path_buf.appendSlice(allocator, "/code-signing-config");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteFunctionCodeSigningConfigOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteFunctionCodeSigningConfigOutput = .{};

    return result;
}
