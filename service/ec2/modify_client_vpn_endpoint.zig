const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ClientConnectOptions = @import("client_connect_options.zig").ClientConnectOptions;
const ClientLoginBannerOptions = @import("client_login_banner_options.zig").ClientLoginBannerOptions;
const ClientRouteEnforcementOptions = @import("client_route_enforcement_options.zig").ClientRouteEnforcementOptions;
const ConnectionLogOptions = @import("connection_log_options.zig").ConnectionLogOptions;
const DnsServersOptionsModifyStructure = @import("dns_servers_options_modify_structure.zig").DnsServersOptionsModifyStructure;
const SelfServicePortal = @import("self_service_portal.zig").SelfServicePortal;

/// Modifies the specified Client VPN endpoint. Modifying the DNS server resets
/// existing client connections.
pub const ModifyClientVpnEndpointInput = struct {
    /// The options for managing connection authorization for new client
    /// connections.
    client_connect_options: ?ClientConnectOptions = null,

    /// Options for enabling a customizable text banner that will be displayed on
    /// Amazon Web Services provided clients when a VPN session is established.
    client_login_banner_options: ?ClientLoginBannerOptions = null,

    /// Client route enforcement is a feature of the Client VPN service that helps
    /// enforce administrator defined routes on devices connected through the VPN. T
    /// his feature helps improve your security posture by ensuring that network
    /// traffic originating from a connected client is not inadvertently sent
    /// outside the VPN tunnel.
    ///
    /// Client route enforcement works by monitoring the route table of a connected
    /// device for routing policy changes to the VPN connection. If the feature
    /// detects any VPN routing policy modifications, it will automatically force an
    /// update to the route table,
    /// reverting it back to the expected route configurations.
    client_route_enforcement_options: ?ClientRouteEnforcementOptions = null,

    /// The ID of the Client VPN endpoint to modify.
    client_vpn_endpoint_id: []const u8,

    /// Information about the client connection logging options.
    ///
    /// If you enable client connection logging, data about client connections is
    /// sent to a
    /// Cloudwatch Logs log stream. The following information is logged:
    ///
    /// * Client connection requests
    ///
    /// * Client connection results (successful and unsuccessful)
    ///
    /// * Reasons for unsuccessful client connection requests
    ///
    /// * Client connection termination time
    connection_log_options: ?ConnectionLogOptions = null,

    /// A brief description of the Client VPN endpoint.
    description: ?[]const u8 = null,

    /// Indicates whether the client VPN session is disconnected after the maximum
    /// timeout specified in `sessionTimeoutHours` is reached. If `true`, users are
    /// prompted to reconnect client VPN. If `false`, client VPN attempts to
    /// reconnect automatically. The default value is `true`.
    disconnect_on_session_timeout: ?bool = null,

    /// Information about the DNS servers to be used by Client VPN connections. A
    /// Client VPN endpoint can have
    /// up to two DNS servers.
    dns_servers: ?DnsServersOptionsModifyStructure = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request, and provides an error response. If you have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise, it
    /// is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The IDs of one or more security groups to apply to the target network.
    security_group_ids: ?[]const []const u8 = null,

    /// Specify whether to enable the self-service portal for the Client VPN
    /// endpoint.
    self_service_portal: ?SelfServicePortal = null,

    /// The ARN of the server certificate to be used. The server certificate must be
    /// provisioned in
    /// Certificate Manager (ACM).
    server_certificate_arn: ?[]const u8 = null,

    /// The maximum VPN session duration time in hours.
    ///
    /// Valid values: `8 | 10 | 12 | 24`
    ///
    /// Default value: `24`
    session_timeout_hours: ?i32 = null,

    /// Indicates whether the VPN is split-tunnel.
    ///
    /// For information about split-tunnel VPN endpoints, see [Split-tunnel Client
    /// VPN
    /// endpoint](https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/split-tunnel-vpn.html) in the
    /// *Client VPN Administrator Guide*.
    split_tunnel: ?bool = null,

    /// The ID of the VPC to associate with the Client VPN endpoint.
    vpc_id: ?[]const u8 = null,

    /// The port number to assign to the Client VPN endpoint for TCP and UDP
    /// traffic.
    ///
    /// Valid Values: `443` | `1194`
    ///
    /// Default Value: `443`
    vpn_port: ?i32 = null,
};

pub const ModifyClientVpnEndpointOutput = struct {
    /// Returns `true` if the request succeeds; otherwise, it returns an error.
    @"return": ?bool = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyClientVpnEndpointOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyClientVpnEndpointInput, options: Options) !ModifyClientVpnEndpointOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyClientVpnEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyClientVpnEndpoint&Version=2016-11-15");
    if (input.client_connect_options) |v| {
        if (v.enabled) |sv| {
            try body_buf.appendSlice(alloc, "&ClientConnectOptions.Enabled=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.lambda_function_arn) |sv| {
            try body_buf.appendSlice(alloc, "&ClientConnectOptions.LambdaFunctionArn=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.client_login_banner_options) |v| {
        if (v.banner_text) |sv| {
            try body_buf.appendSlice(alloc, "&ClientLoginBannerOptions.BannerText=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.enabled) |sv| {
            try body_buf.appendSlice(alloc, "&ClientLoginBannerOptions.Enabled=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.client_route_enforcement_options) |v| {
        if (v.enforced) |sv| {
            try body_buf.appendSlice(alloc, "&ClientRouteEnforcementOptions.Enforced=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    try body_buf.appendSlice(alloc, "&ClientVpnEndpointId=");
    try appendUrlEncoded(alloc, &body_buf, input.client_vpn_endpoint_id);
    if (input.connection_log_options) |v| {
        if (v.cloudwatch_log_group) |sv| {
            try body_buf.appendSlice(alloc, "&ConnectionLogOptions.CloudwatchLogGroup=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.cloudwatch_log_stream) |sv| {
            try body_buf.appendSlice(alloc, "&ConnectionLogOptions.CloudwatchLogStream=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.enabled) |sv| {
            try body_buf.appendSlice(alloc, "&ConnectionLogOptions.Enabled=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.disconnect_on_session_timeout) |v| {
        try body_buf.appendSlice(alloc, "&DisconnectOnSessionTimeout=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.dns_servers) |v| {
        if (v.enabled) |sv| {
            try body_buf.appendSlice(alloc, "&DnsServers.Enabled=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.security_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecurityGroupIds.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.self_service_portal) |v| {
        try body_buf.appendSlice(alloc, "&SelfServicePortal=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.server_certificate_arn) |v| {
        try body_buf.appendSlice(alloc, "&ServerCertificateArn=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.session_timeout_hours) |v| {
        try body_buf.appendSlice(alloc, "&SessionTimeoutHours=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.split_tunnel) |v| {
        try body_buf.appendSlice(alloc, "&SplitTunnel=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.vpc_id) |v| {
        try body_buf.appendSlice(alloc, "&VpcId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.vpn_port) |v| {
        try body_buf.appendSlice(alloc, "&VpnPort=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyClientVpnEndpointOutput {
    _ = status;
    _ = headers;
    _ = alloc;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyClientVpnEndpointOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "return")) {
                    result.@"return" = std.mem.eql(u8, try reader.readElementText(), "true");
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
