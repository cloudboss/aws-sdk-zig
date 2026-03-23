const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ClientVpnAuthorizationRuleStatus = @import("client_vpn_authorization_rule_status.zig").ClientVpnAuthorizationRuleStatus;
const serde = @import("serde.zig");

pub const AuthorizeClientVpnIngressInput = struct {
    /// The ID of the group to grant access to, for example, the Active Directory
    /// group or identity provider (IdP) group. Required if `AuthorizeAllGroups` is
    /// `false` or not specified.
    access_group_id: ?[]const u8 = null,

    /// Indicates whether to grant access to all clients. Specify `true` to grant
    /// all
    /// clients who successfully establish a VPN connection access to the network.
    /// Must be set
    /// to `true` if `AccessGroupId` is not specified.
    authorize_all_groups: ?bool = null,

    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request.
    /// For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: ?[]const u8 = null,

    /// The ID of the Client VPN endpoint.
    client_vpn_endpoint_id: []const u8,

    /// A brief description of the authorization rule.
    description: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request, and provides an error response. If you have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise, it
    /// is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The IPv4 address range, in CIDR notation, of the network for which access is
    /// being authorized.
    target_network_cidr: []const u8,
};

pub const AuthorizeClientVpnIngressOutput = struct {
    /// The current state of the authorization rule.
    status: ?ClientVpnAuthorizationRuleStatus = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AuthorizeClientVpnIngressInput, options: CallOptions) !AuthorizeClientVpnIngressOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: AuthorizeClientVpnIngressInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=AuthorizeClientVpnIngress&Version=2016-11-15");
    if (input.access_group_id) |v| {
        try body_buf.appendSlice(allocator, "&AccessGroupId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.authorize_all_groups) |v| {
        try body_buf.appendSlice(allocator, "&AuthorizeAllGroups=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&ClientVpnEndpointId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.client_vpn_endpoint_id);
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&TargetNetworkCidr=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.target_network_cidr);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AuthorizeClientVpnIngressOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: AuthorizeClientVpnIngressOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "status")) {
                    result.status = try serde.deserializeClientVpnAuthorizationRuleStatus(allocator, &reader);
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
