const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const DnsProtocol = @import("dns_protocol.zig").DnsProtocol;
const CRResourceStatus = @import("cr_resource_status.zig").CRResourceStatus;

pub const UpdateAccessSourceInput = struct {
    /// The unique identifier of the access source to update.
    access_source_id: []const u8,

    /// The CIDR block for the access source.
    cidr: ?[]const u8 = null,

    /// The IP address type for the access source.
    ip_address_type: ?IpAddressType = null,

    /// The name of the access source.
    name: ?[]const u8 = null,

    /// The protocol for the access source.
    protocol: ?DnsProtocol = null,

    pub const json_field_names = .{
        .access_source_id = "accessSourceId",
        .cidr = "cidr",
        .ip_address_type = "ipAddressType",
        .name = "name",
        .protocol = "protocol",
    };
};

pub const UpdateAccessSourceOutput = struct {
    /// The Amazon Resource Name (ARN) of the updated access source.
    arn: []const u8,

    /// The CIDR block of the updated access source.
    cidr: []const u8,

    /// The date and time when the access source was originally created.
    created_at: i64,

    /// The ID of the DNS view associated with the updated access source.
    dns_view_id: []const u8,

    /// The unique identifier of the updated access source.
    id: []const u8,

    /// The IP address type of the updated access source.
    ip_address_type: IpAddressType,

    /// The name of the updated access source.
    name: ?[]const u8 = null,

    /// The protocol of the updated access source.
    protocol: DnsProtocol,

    /// The current status of the updated access source.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAccessSourceInput, options: CallOptions) !UpdateAccessSourceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAccessSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/access-sources/");
    try path_buf.appendSlice(allocator, input.access_source_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.cidr) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"cidr\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.protocol) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"protocol\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAccessSourceOutput {
    var result: UpdateAccessSourceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateAccessSourceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
