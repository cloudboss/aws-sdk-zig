const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FunctionConfig = @import("function_config.zig").FunctionConfig;
const Tags = @import("tags.zig").Tags;
const ConnectionFunctionSummary = @import("connection_function_summary.zig").ConnectionFunctionSummary;
const serde = @import("serde.zig");

pub const CreateConnectionFunctionInput = struct {
    /// The code for the connection function.
    connection_function_code: []const u8,

    connection_function_config: FunctionConfig,

    /// A name for the connection function.
    name: []const u8,

    tags: ?Tags = null,
};

pub const CreateConnectionFunctionOutput = struct {
    /// The summary for the connection function.
    connection_function_summary: ?ConnectionFunctionSummary = null,

    /// The version identifier for the current version of the connection function.
    e_tag: ?[]const u8 = null,

    /// The location of the connection function.
    location: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConnectionFunctionInput, options: CallOptions) !CreateConnectionFunctionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConnectionFunctionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2020-05-31/connection-function";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<CreateConnectionFunctionRequest xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    try body_buf.appendSlice(allocator, "<ConnectionFunctionCode>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.connection_function_code);
    try body_buf.appendSlice(allocator, "</ConnectionFunctionCode>");
    try body_buf.appendSlice(allocator, "<ConnectionFunctionConfig>");
    try serde.serializeFunctionConfig(allocator, &body_buf, input.connection_function_config);
    try body_buf.appendSlice(allocator, "</ConnectionFunctionConfig>");
    try body_buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.name);
    try body_buf.appendSlice(allocator, "</Name>");
    if (input.tags) |v| {
        try body_buf.appendSlice(allocator, "<Tags>");
        try serde.serializeTags(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</Tags>");
    }
    try body_buf.appendSlice(allocator, "</CreateConnectionFunctionRequest>");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConnectionFunctionOutput {
    var result: CreateConnectionFunctionOutput = .{};
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
