const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteRealtimeLogConfigInput = struct {
    /// The Amazon Resource Name (ARN) of the real-time log configuration to delete.
    arn: ?[]const u8 = null,

    /// The name of the real-time log configuration to delete.
    name: ?[]const u8 = null,
};

pub const DeleteRealtimeLogConfigOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteRealtimeLogConfigInput, options: CallOptions) !DeleteRealtimeLogConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteRealtimeLogConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2020-05-31/delete-realtime-log-config";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<DeleteRealtimeLogConfigRequest xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    if (input.arn) |v| {
        try body_buf.appendSlice(allocator, "<ARN>");
        try aws.xml.appendXmlEscaped(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</ARN>");
    }
    if (input.name) |v| {
        try body_buf.appendSlice(allocator, "<Name>");
        try aws.xml.appendXmlEscaped(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</Name>");
    }
    try body_buf.appendSlice(allocator, "</DeleteRealtimeLogConfigRequest>");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteRealtimeLogConfigOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteRealtimeLogConfigOutput = .{};

    return result;
}
