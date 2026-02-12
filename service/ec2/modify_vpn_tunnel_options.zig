const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ModifyVpnTunnelOptionsSpecification = @import("modify_vpn_tunnel_options_specification.zig").ModifyVpnTunnelOptionsSpecification;
const VpnConnection = @import("vpn_connection.zig").VpnConnection;
const serde = @import("serde.zig");

/// Modifies the options for a VPN tunnel in an Amazon Web Services Site-to-Site
/// VPN connection. You can modify
/// multiple options for a tunnel in a single request, but you can only modify
/// one tunnel at
/// a time. For more information, see [Site-to-Site VPN tunnel options for your
/// Site-to-Site VPN
/// connection](https://docs.aws.amazon.com/vpn/latest/s2svpn/VPNTunnels.html)
/// in the *Amazon Web Services Site-to-Site VPN User Guide*.
pub const ModifyVpnTunnelOptionsInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually
    /// making the request, and provides an error response. If you have the required
    /// permissions, the error response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Specifies the storage mode for the pre-shared key (PSK). Valid values are
    /// `Standard` (stored in Site-to-Site VPN service) or `SecretsManager` (stored
    /// in Amazon Web Services Secrets Manager).
    pre_shared_key_storage: ?[]const u8 = null,

    /// Choose whether or not to trigger immediate tunnel replacement. This is only
    /// applicable when turning on or off `EnableTunnelLifecycleControl`.
    ///
    /// Valid values: `True` | `False`
    skip_tunnel_replacement: ?bool = null,

    /// The tunnel options to modify.
    tunnel_options: ModifyVpnTunnelOptionsSpecification,

    /// The ID of the Amazon Web Services Site-to-Site VPN connection.
    vpn_connection_id: []const u8,

    /// The external IP address of the VPN tunnel.
    vpn_tunnel_outside_ip_address: []const u8,
};

pub const ModifyVpnTunnelOptionsOutput = struct {
    /// Information about the VPN connection.
    vpn_connection: ?VpnConnection = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyVpnTunnelOptionsOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyVpnTunnelOptionsInput, options: Options) !ModifyVpnTunnelOptionsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyVpnTunnelOptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyVpnTunnelOptions&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.pre_shared_key_storage) |v| {
        try body_buf.appendSlice(alloc, "&PreSharedKeyStorage=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.skip_tunnel_replacement) |v| {
        try body_buf.appendSlice(alloc, "&SkipTunnelReplacement=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.tunnel_options.dpd_timeout_action) |sv| {
        try body_buf.appendSlice(alloc, "&TunnelOptions.DPDTimeoutAction=");
        try appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.tunnel_options.dpd_timeout_seconds) |sv| {
        try body_buf.appendSlice(alloc, "&TunnelOptions.DPDTimeoutSeconds=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
    }
    if (input.tunnel_options.enable_tunnel_lifecycle_control) |sv| {
        try body_buf.appendSlice(alloc, "&TunnelOptions.EnableTunnelLifecycleControl=");
        try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
    }
    if (input.tunnel_options.phase_1_lifetime_seconds) |sv| {
        try body_buf.appendSlice(alloc, "&TunnelOptions.Phase1LifetimeSeconds=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
    }
    if (input.tunnel_options.phase_2_lifetime_seconds) |sv| {
        try body_buf.appendSlice(alloc, "&TunnelOptions.Phase2LifetimeSeconds=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
    }
    if (input.tunnel_options.pre_shared_key) |sv| {
        try body_buf.appendSlice(alloc, "&TunnelOptions.PreSharedKey=");
        try appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.tunnel_options.rekey_fuzz_percentage) |sv| {
        try body_buf.appendSlice(alloc, "&TunnelOptions.RekeyFuzzPercentage=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
    }
    if (input.tunnel_options.rekey_margin_time_seconds) |sv| {
        try body_buf.appendSlice(alloc, "&TunnelOptions.RekeyMarginTimeSeconds=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
    }
    if (input.tunnel_options.replay_window_size) |sv| {
        try body_buf.appendSlice(alloc, "&TunnelOptions.ReplayWindowSize=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
    }
    if (input.tunnel_options.startup_action) |sv| {
        try body_buf.appendSlice(alloc, "&TunnelOptions.StartupAction=");
        try appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.tunnel_options.tunnel_inside_cidr) |sv| {
        try body_buf.appendSlice(alloc, "&TunnelOptions.TunnelInsideCidr=");
        try appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.tunnel_options.tunnel_inside_ipv_6_cidr) |sv| {
        try body_buf.appendSlice(alloc, "&TunnelOptions.TunnelInsideIpv6Cidr=");
        try appendUrlEncoded(alloc, &body_buf, sv);
    }
    try body_buf.appendSlice(alloc, "&VpnConnectionId=");
    try appendUrlEncoded(alloc, &body_buf, input.vpn_connection_id);
    try body_buf.appendSlice(alloc, "&VpnTunnelOutsideIpAddress=");
    try appendUrlEncoded(alloc, &body_buf, input.vpn_tunnel_outside_ip_address);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyVpnTunnelOptionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyVpnTunnelOptionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "vpnConnection")) {
                    result.vpn_connection = try serde.deserializeVpnConnection(&reader, alloc);
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
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
