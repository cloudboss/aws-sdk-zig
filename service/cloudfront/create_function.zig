const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FunctionConfig = @import("function_config.zig").FunctionConfig;
const Tags = @import("tags.zig").Tags;
const FunctionSummary = @import("function_summary.zig").FunctionSummary;
const serde = @import("serde.zig");

pub const CreateFunctionInput = struct {
    /// The function code. For more information about writing a CloudFront function,
    /// see [Writing function code for CloudFront
    /// Functions](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/writing-function-code.html) in the *Amazon CloudFront Developer Guide*.
    function_code: []const u8,

    /// Configuration information about the function, including an optional comment
    /// and the function's runtime.
    function_config: FunctionConfig,

    /// A name to identify the function.
    name: []const u8,

    tags: ?Tags = null,
};

pub const CreateFunctionOutput = struct {
    /// The version identifier for the current version of the CloudFront function.
    e_tag: ?[]const u8 = null,

    /// Contains configuration information and metadata about a CloudFront function.
    function_summary: ?FunctionSummary = null,

    /// The URL of the CloudFront function. Use the URL to manage the function with
    /// the CloudFront API.
    location: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFunctionInput, options: CallOptions) !CreateFunctionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFunctionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2020-05-31/function";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<CreateFunctionRequest xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    try body_buf.appendSlice(allocator, "<FunctionCode>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.function_code);
    try body_buf.appendSlice(allocator, "</FunctionCode>");
    try body_buf.appendSlice(allocator, "<FunctionConfig>");
    try serde.serializeFunctionConfig(allocator, &body_buf, input.function_config);
    try body_buf.appendSlice(allocator, "</FunctionConfig>");
    try body_buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.name);
    try body_buf.appendSlice(allocator, "</Name>");
    if (input.tags) |v| {
        try body_buf.appendSlice(allocator, "<Tags>");
        try serde.serializeTags(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</Tags>");
    }
    try body_buf.appendSlice(allocator, "</CreateFunctionRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFunctionOutput {
    var result: CreateFunctionOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }
    if (headers.get("location")) |value| {
        result.location = try allocator.dupe(u8, value);
    }

    return result;
}
