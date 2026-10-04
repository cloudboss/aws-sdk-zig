const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FunctionStage = @import("function_stage.zig").FunctionStage;
const ConnectionFunctionTestResult = @import("connection_function_test_result.zig").ConnectionFunctionTestResult;
const serde = @import("serde.zig");

pub const TestConnectionFunctionInput = struct {
    /// The connection object.
    connection_object: []const u8,

    /// The connection function ID.
    id: []const u8,

    /// The current version (`ETag` value) of the connection function.
    if_match: []const u8,

    /// The connection function stage.
    stage: ?FunctionStage = null,
};

pub const TestConnectionFunctionOutput = struct {
    /// The connection function test result.
    connection_function_test_result: ?ConnectionFunctionTestResult = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TestConnectionFunctionInput, options: CallOptions) !TestConnectionFunctionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: TestConnectionFunctionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2020-05-31/connection-function/");
    try path_buf.appendSlice(allocator, input.id);
    try path_buf.appendSlice(allocator, "/test");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<TestConnectionFunctionRequest xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    try body_buf.appendSlice(allocator, "<ConnectionObject>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.connection_object);
    try body_buf.appendSlice(allocator, "</ConnectionObject>");
    if (input.stage) |v| {
        try body_buf.appendSlice(allocator, "<Stage>");
        try body_buf.appendSlice(allocator, v.wireName());
        try body_buf.appendSlice(allocator, "</Stage>");
    }
    try body_buf.appendSlice(allocator, "</TestConnectionFunctionRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    try request.headers.put(allocator, "If-Match", input.if_match);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TestConnectionFunctionOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: TestConnectionFunctionOutput = .{};

    return result;
}
