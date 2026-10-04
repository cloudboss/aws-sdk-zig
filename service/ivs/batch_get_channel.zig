const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Channel = @import("channel.zig").Channel;
const BatchError = @import("batch_error.zig").BatchError;

pub const BatchGetChannelInput = struct {
    /// Array of ARNs, one per channel.
    arns: []const []const u8,

    pub const json_field_names = .{
        .arns = "arns",
    };
};

pub const BatchGetChannelOutput = struct {
    /// See
    /// [Access-Control-Allow-Origin](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Access-Control-Allow-Origin) in the MDN Web Docs.
    access_control_allow_origin: ?[]const u8 = null,

    /// See
    /// [Access-Control-Expose-Headers](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Access-Control-Expose-Headers) in the MDN Web Docs.
    access_control_expose_headers: ?[]const u8 = null,

    /// See
    /// [Cache-Control](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Cache-Control) in the MDN Web Docs.
    cache_control: ?[]const u8 = null,

    channels: ?[]const Channel = null,

    /// See
    /// [Content-Security-Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Content-Security-Policy) in the MDN Web Docs.
    content_security_policy: ?[]const u8 = null,

    /// Each error object is related to a specific ARN in the request.
    errors: ?[]const BatchError = null,

    /// See
    /// [Strict-Transport-Security](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Strict-Transport-Security) in the MDN Web Docs.
    strict_transport_security: ?[]const u8 = null,

    /// See
    /// [X-Content-Type-Options](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/X-Content-Type-Options) in the MDN Web Docs.
    x_content_type_options: ?[]const u8 = null,

    /// See
    /// [X-Frame-Options](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/X-Frame-Options) in the MDN Web Docs.
    x_frame_options: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_control_allow_origin = "accessControlAllowOrigin",
        .access_control_expose_headers = "accessControlExposeHeaders",
        .cache_control = "cacheControl",
        .channels = "channels",
        .content_security_policy = "contentSecurityPolicy",
        .errors = "errors",
        .strict_transport_security = "strictTransportSecurity",
        .x_content_type_options = "xContentTypeOptions",
        .x_frame_options = "xFrameOptions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetChannelInput, options: CallOptions) !BatchGetChannelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ivs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetChannelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivs", "ivs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/BatchGetChannel";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"arns\":");
    try aws.json.writeValue(@TypeOf(input.arns), input.arns, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetChannelOutput {
    var result: BatchGetChannelOutput = try aws.json.parseJsonObject(
        BatchGetChannelOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    if (headers.get("access-control-allow-origin")) |value| {
        result.access_control_allow_origin = try allocator.dupe(u8, value);
    }
    if (headers.get("access-control-expose-headers")) |value| {
        result.access_control_expose_headers = try allocator.dupe(u8, value);
    }
    if (headers.get("cache-control")) |value| {
        result.cache_control = try allocator.dupe(u8, value);
    }
    if (headers.get("content-security-policy")) |value| {
        result.content_security_policy = try allocator.dupe(u8, value);
    }
    if (headers.get("strict-transport-security")) |value| {
        result.strict_transport_security = try allocator.dupe(u8, value);
    }
    if (headers.get("x-content-type-options")) |value| {
        result.x_content_type_options = try allocator.dupe(u8, value);
    }
    if (headers.get("x-frame-options")) |value| {
        result.x_frame_options = try allocator.dupe(u8, value);
    }

    return result;
}
