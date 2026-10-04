const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const IpamCidrConfig = @import("ipam_cidr_config.zig").IpamCidrConfig;
const Tags = @import("tags.zig").Tags;
const AnycastIpList = @import("anycast_ip_list.zig").AnycastIpList;
const serde = @import("serde.zig");

pub const CreateAnycastIpListInput = struct {
    /// The IP address type for the Anycast static IP list. You can specify one of
    /// the following options:
    ///
    /// * `ipv4` only
    /// * `ipv6` only
    /// * `dualstack` - Allocate a list of both IPv4 and IPv6 addresses
    ip_address_type: ?IpAddressType = null,

    /// A list of IPAM CIDR configurations that specify the IP address ranges and
    /// IPAM pool settings for creating the Anycast static IP list.
    ipam_cidr_configs: ?[]const IpamCidrConfig = null,

    /// The number of static IP addresses that are allocated to the Anycast static
    /// IP list. Valid values: 21 or 3.
    ip_count: i32,

    /// Name of the Anycast static IP list.
    name: []const u8,

    tags: ?Tags = null,
};

pub const CreateAnycastIpListOutput = struct {
    /// A response structure that includes the version identifier (ETag) and the
    /// created AnycastIpList structure.
    anycast_ip_list: ?AnycastIpList = null,

    /// The version identifier for the current version of the Anycast static IP
    /// list.
    e_tag: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAnycastIpListInput, options: CallOptions) !CreateAnycastIpListOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAnycastIpListInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2020-05-31/anycast-ip-list";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<CreateAnycastIpListRequest xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
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
    try body_buf.appendSlice(allocator, "<IpCount>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.ip_count}) catch "";
        try body_buf.appendSlice(allocator, num_str);
    }
    try body_buf.appendSlice(allocator, "</IpCount>");
    try body_buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.name);
    try body_buf.appendSlice(allocator, "</Name>");
    if (input.tags) |v| {
        try body_buf.appendSlice(allocator, "<Tags>");
        try serde.serializeTags(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</Tags>");
    }
    try body_buf.appendSlice(allocator, "</CreateAnycastIpListRequest>");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAnycastIpListOutput {
    var result: CreateAnycastIpListOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }

    return result;
}
