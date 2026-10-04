const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FunctionSummary = @import("function_summary.zig").FunctionSummary;
const serde = @import("serde.zig");

pub const PublishFunctionInput = struct {
    /// The current version (`ETag` value) of the function that you are publishing,
    /// which you can get using `DescribeFunction`.
    if_match: []const u8,

    /// The name of the function that you are publishing.
    name: []const u8,
};

pub const PublishFunctionOutput = struct {
    /// Contains configuration information and metadata about a CloudFront function.
    function_summary: ?FunctionSummary = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PublishFunctionInput, options: CallOptions) !PublishFunctionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudfront", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PublishFunctionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2020-05-31/function/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/publish");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "If-Match", input.if_match);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PublishFunctionOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PublishFunctionOutput = .{};

    return result;
}
