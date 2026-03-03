const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const IpamResourceCidr = @import("ipam_resource_cidr.zig").IpamResourceCidr;
const serde = @import("serde.zig");

pub const ModifyIpamResourceCidrInput = struct {
    /// The ID of the current scope that the resource CIDR is in.
    current_ipam_scope_id: []const u8,

    /// The ID of the scope you want to transfer the resource CIDR to.
    destination_ipam_scope_id: ?[]const u8 = null,

    /// A check for whether you have the required permissions for the action without
    /// actually making the request
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Determines if the resource is monitored by IPAM. If a resource is monitored,
    /// the resource is discovered by IPAM and you can view details about the
    /// resource’s CIDR.
    monitored: bool,

    /// The CIDR of the resource you want to modify.
    resource_cidr: []const u8,

    /// The ID of the resource you want to modify.
    resource_id: []const u8,

    /// The Amazon Web Services Region of the resource you want to modify.
    resource_region: []const u8,
};

pub const ModifyIpamResourceCidrOutput = struct {
    /// The CIDR of the resource.
    ipam_resource_cidr: ?IpamResourceCidr = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyIpamResourceCidrInput, options: CallOptions) !ModifyIpamResourceCidrOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyIpamResourceCidrInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ModifyIpamResourceCidr&Version=2016-11-15");
    try body_buf.appendSlice(allocator, "&CurrentIpamScopeId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.current_ipam_scope_id);
    if (input.destination_ipam_scope_id) |v| {
        try body_buf.appendSlice(allocator, "&DestinationIpamScopeId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&Monitored=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, if (input.monitored) "true" else "false");
    try body_buf.appendSlice(allocator, "&ResourceCidr=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.resource_cidr);
    try body_buf.appendSlice(allocator, "&ResourceId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.resource_id);
    try body_buf.appendSlice(allocator, "&ResourceRegion=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.resource_region);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyIpamResourceCidrOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyIpamResourceCidrOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ipamResourceCidr")) {
                    result.ipam_resource_cidr = try serde.deserializeIpamResourceCidr(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);


    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
