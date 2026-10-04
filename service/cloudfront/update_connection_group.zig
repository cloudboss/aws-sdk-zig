const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectionGroup = @import("connection_group.zig").ConnectionGroup;
const serde = @import("serde.zig");

pub const UpdateConnectionGroupInput = struct {
    /// The ID of the Anycast static IP list.
    anycast_ip_list_id: ?[]const u8 = null,

    /// Whether the connection group is enabled.
    enabled: ?bool = null,

    /// The ID of the connection group.
    id: []const u8,

    /// The value of the `ETag` header that you received when retrieving the
    /// connection group that you're updating.
    if_match: []const u8,

    /// Enable IPv6 for the connection group. For more information, see [Enable
    /// IPv6](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#DownloadDistValuesEnableIPv6) in the *Amazon CloudFront Developer Guide*.
    ipv_6_enabled: ?bool = null,
};

pub const UpdateConnectionGroupOutput = struct {
    /// The connection group that you updated.
    connection_group: ?ConnectionGroup = null,

    /// The current version of the connection group.
    e_tag: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateConnectionGroupInput, options: CallOptions) !UpdateConnectionGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateConnectionGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2020-05-31/connection-group/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<UpdateConnectionGroupRequest xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    if (input.anycast_ip_list_id) |v| {
        try body_buf.appendSlice(allocator, "<AnycastIpListId>");
        try aws.xml.appendXmlEscaped(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</AnycastIpListId>");
    }
    if (input.enabled) |v| {
        try body_buf.appendSlice(allocator, "<Enabled>");
        try body_buf.appendSlice(allocator, if (v) "true" else "false");
        try body_buf.appendSlice(allocator, "</Enabled>");
    }
    if (input.ipv_6_enabled) |v| {
        try body_buf.appendSlice(allocator, "<Ipv6Enabled>");
        try body_buf.appendSlice(allocator, if (v) "true" else "false");
        try body_buf.appendSlice(allocator, "</Ipv6Enabled>");
    }
    try body_buf.appendSlice(allocator, "</UpdateConnectionGroupRequest>");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateConnectionGroupOutput {
    var result: UpdateConnectionGroupOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }

    return result;
}
