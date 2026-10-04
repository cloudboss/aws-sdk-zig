const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const DnsProtocol = @import("dns_protocol.zig").DnsProtocol;
const CRResourceStatus = @import("cr_resource_status.zig").CRResourceStatus;

pub const CreateAccessSourceInput = struct {
    /// The IP address or CIDR range that is allowed to send DNS queries to the
    /// Route 53 Global Resolver.
    cidr: []const u8,

    /// A unique string that identifies the request and ensures idempotency.
    client_token: ?[]const u8 = null,

    /// The ID of the DNS view to associate with this access source.
    dns_view_id: []const u8,

    /// The IP address type for this access source. Valid values are IPv4 and IPv6
    /// (if the Route 53 Global Resolver supports dual-stack).
    ip_address_type: ?IpAddressType = null,

    /// A descriptive name for the access source.
    name: ?[]const u8 = null,

    /// The DNS protocol that is permitted for this access source. Valid values are
    /// Do53 (DNS over port 53), DoT (DNS over TLS), and DoH (DNS over HTTPS).
    protocol: DnsProtocol,

    /// Tags to associate with the access source.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .cidr = "cidr",
        .client_token = "clientToken",
        .dns_view_id = "dnsViewId",
        .ip_address_type = "ipAddressType",
        .name = "name",
        .protocol = "protocol",
        .tags = "tags",
    };
};

pub const CreateAccessSourceOutput = struct {
    /// The Amazon Resource Name (ARN) of the access source.
    arn: []const u8,

    /// The IP address or CIDR range that is allowed to send DNS queries to the
    /// Route 53 Global Resolver.
    cidr: []const u8,

    /// The date and time when the access source was created.
    created_at: i64,

    /// The ID of the DNS view associated with this access source.
    dns_view_id: []const u8,

    /// The unique identifier for the access source.
    id: []const u8,

    /// The IP address type for this access source (IPv4 or IPv6).
    ip_address_type: IpAddressType,

    /// The descriptive name of the access source.
    name: ?[]const u8 = null,

    /// The DNS protocol that is permitted for this access source (Do53, DoT, or
    /// DoH).
    protocol: DnsProtocol,

    /// The operational status of the access source.
    status: CRResourceStatus,

    /// The date and time when the access source was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .cidr = "cidr",
        .created_at = "createdAt",
        .dns_view_id = "dnsViewId",
        .id = "id",
        .ip_address_type = "ipAddressType",
        .name = "name",
        .protocol = "protocol",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAccessSourceInput, options: CallOptions) !CreateAccessSourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53globalresolver", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAccessSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/access-sources";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"cidr\":");
    try aws.json.writeValue(@TypeOf(input.cidr), input.cidr, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"dnsViewId\":");
    try aws.json.writeValue(@TypeOf(input.dns_view_id), input.dns_view_id, allocator, &body_buf);
    has_prev = true;
    if (input.ip_address_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ipAddressType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"protocol\":");
    try aws.json.writeValue(@TypeOf(input.protocol), input.protocol, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAccessSourceOutput {
    var result: CreateAccessSourceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAccessSourceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
