const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ClientVpnAuthorizationRuleStatus = @import("client_vpn_authorization_rule_status.zig").ClientVpnAuthorizationRuleStatus;
const serde = @import("serde.zig");

pub const RevokeClientVpnIngressInput = struct {
    /// The ID of the Active Directory group for which to revoke access.
    access_group_id: ?[]const u8 = null,

    /// The ID of the Client VPN endpoint with which the authorization rule is
    /// associated.
    client_vpn_endpoint_id: []const u8,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request, and provides an error response. If you have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise, it
    /// is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Indicates whether access should be revoked for all groups for a single
    /// `TargetNetworkCidr` that earlier authorized ingress for all groups using
    /// `AuthorizeAllGroups`.
    /// This does not impact other authorization rules that allowed ingress to the
    /// same `TargetNetworkCidr` with a specific `AccessGroupId`.
    revoke_all_groups: ?bool = null,

    /// The IPv4 address range, in CIDR notation, of the network for which access is
    /// being removed.
    target_network_cidr: []const u8,
};

pub const RevokeClientVpnIngressOutput = struct {
    /// The current state of the authorization rule.
    status: ?ClientVpnAuthorizationRuleStatus = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *RevokeClientVpnIngressOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: RevokeClientVpnIngressInput, options: Options) !RevokeClientVpnIngressOutput {
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
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: RevokeClientVpnIngressInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=RevokeClientVpnIngress&Version=2016-11-15");
    if (input.access_group_id) |v| {
        try body_buf.appendSlice(alloc, "&AccessGroupId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&ClientVpnEndpointId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.client_vpn_endpoint_id);
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.revoke_all_groups) |v| {
        try body_buf.appendSlice(alloc, "&RevokeAllGroups=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&TargetNetworkCidr=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.target_network_cidr);

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !RevokeClientVpnIngressOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: RevokeClientVpnIngressOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "status")) {
                    result.status = try serde.deserializeClientVpnAuthorizationRuleStatus(&reader, alloc);
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

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
