const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FunctionConfig = @import("function_config.zig").FunctionConfig;
const FunctionSummary = @import("function_summary.zig").FunctionSummary;
const serde = @import("serde.zig");

pub const UpdateFunctionInput = struct {
    /// The function code. For more information about writing a CloudFront function,
    /// see [Writing function code for CloudFront
    /// Functions](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/writing-function-code.html) in the *Amazon CloudFront Developer Guide*.
    function_code: []const u8,

    /// Configuration information about the function.
    function_config: FunctionConfig,

    /// The current version (`ETag` value) of the function that you are updating,
    /// which you can get using `DescribeFunction`.
    if_match: []const u8,

    /// The name of the function that you are updating.
    name: []const u8,
};

pub const UpdateFunctionOutput = struct {
    /// The version identifier for the current version of the CloudFront function.
    e_tag: ?[]const u8 = null,

    /// Contains configuration information and metadata about a CloudFront function.
    function_summary: ?FunctionSummary = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFunctionInput, options: CallOptions) !UpdateFunctionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFunctionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2020-05-31/function/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<UpdateFunctionRequest xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    try body_buf.appendSlice(allocator, "<FunctionCode>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.function_code);
    try body_buf.appendSlice(allocator, "</FunctionCode>");
    try body_buf.appendSlice(allocator, "<FunctionConfig>");
    try serde.serializeFunctionConfig(allocator, &body_buf, input.function_config);
    try body_buf.appendSlice(allocator, "</FunctionConfig>");
    try body_buf.appendSlice(allocator, "</UpdateFunctionRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    try request.headers.put(allocator, "If-Match", input.if_match);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFunctionOutput {
    var result: UpdateFunctionOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("ettag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }

    return result;
}
