const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FunctionStage = @import("function_stage.zig").FunctionStage;
const TestResult = @import("test_result.zig").TestResult;
const serde = @import("serde.zig");

pub const TestFunctionInput = struct {
    /// The event object to test the function with. For more information about the
    /// structure of the event object, see [Testing
    /// functions](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/managing-functions.html#test-function) in the *Amazon CloudFront Developer Guide*.
    event_object: []const u8,

    /// The current version (`ETag` value) of the function that you are testing,
    /// which you can get using `DescribeFunction`.
    if_match: []const u8,

    /// The name of the function that you are testing.
    name: []const u8,

    /// The stage of the function that you are testing, either `DEVELOPMENT` or
    /// `LIVE`.
    stage: ?FunctionStage = null,
};

pub const TestFunctionOutput = struct {
    /// An object that represents the result of running the function with the
    /// provided event object.
    test_result: ?TestResult = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TestFunctionInput, options: CallOptions) !TestFunctionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: TestFunctionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2020-05-31/function/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/test");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<TestFunctionRequest xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    try body_buf.appendSlice(allocator, "<EventObject>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.event_object);
    try body_buf.appendSlice(allocator, "</EventObject>");
    if (input.stage) |v| {
        try body_buf.appendSlice(allocator, "<Stage>");
        try body_buf.appendSlice(allocator, v.wireName());
        try body_buf.appendSlice(allocator, "</Stage>");
    }
    try body_buf.appendSlice(allocator, "</TestFunctionRequest>");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TestFunctionOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: TestFunctionOutput = .{};

    return result;
}
