const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const IpamCidrConfig = @import("ipam_cidr_config.zig").IpamCidrConfig;
const AnycastIpList = @import("anycast_ip_list.zig").AnycastIpList;
const serde = @import("serde.zig");

pub const UpdateAnycastIpListInput = struct {
    /// The ID of the Anycast static IP list.
    id: []const u8,

    /// The current version (ETag value) of the Anycast static IP list that you are
    /// updating.
    if_match: []const u8,

    /// The IP address type for the Anycast static IP list. You can specify one of
    /// the following options:
    ///
    /// * `ipv4` only
    /// * `ipv6` only
    /// * `dualstack` - Allocate a list of both IPv4 and IPv6 addresses
    ip_address_type: ?IpAddressType = null,

    /// A list of IPAM CIDR configurations that specify the IP address ranges and
    /// IPAM pool settings for updating the Anycast static IP list.
    ipam_cidr_configs: ?[]const IpamCidrConfig = null,
};

pub const UpdateAnycastIpListOutput = struct {
    anycast_ip_list: ?AnycastIpList = null,

    /// The current version of the Anycast static IP list.
    e_tag: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAnycastIpListInput, options: CallOptions) !UpdateAnycastIpListOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAnycastIpListInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2020-05-31/anycast-ip-list/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<UpdateAnycastIpListRequest xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    if (input.ip_address_type) |v| {
        try body_buf.appendSlice(allocator, "<IpAddressType>");
        try body_buf.appendSlice(allocator, v.wireName());
        try body_buf.appendSlice(allocator, "</IpAddressType>");
    }
    if (input.ipam_cidr_configs) |v| {
        try body_buf.appendSlice(allocator, "<IpamCidrConfigs>");
        try serde.serializeIpamCidrConfigList(allocator, &body_buf, v, "IpamCidrConfig");
        try body_buf.appendSlice(allocator, "</IpamCidrConfigs>");
    }
    try body_buf.appendSlice(allocator, "</UpdateAnycastIpListRequest>");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAnycastIpListOutput {
    var result: UpdateAnycastIpListOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }

    return result;
}
