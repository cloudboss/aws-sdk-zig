const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ClientVpnAuthenticationRequest = @import("client_vpn_authentication_request.zig").ClientVpnAuthenticationRequest;
const ClientConnectOptions = @import("client_connect_options.zig").ClientConnectOptions;
const ClientLoginBannerOptions = @import("client_login_banner_options.zig").ClientLoginBannerOptions;
const ClientRouteEnforcementOptions = @import("client_route_enforcement_options.zig").ClientRouteEnforcementOptions;
const ConnectionLogOptions = @import("connection_log_options.zig").ConnectionLogOptions;
const EndpointIpAddressType = @import("endpoint_ip_address_type.zig").EndpointIpAddressType;
const SelfServicePortal = @import("self_service_portal.zig").SelfServicePortal;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const TrafficIpAddressType = @import("traffic_ip_address_type.zig").TrafficIpAddressType;
const TransportProtocol = @import("transport_protocol.zig").TransportProtocol;
const ClientVpnEndpointStatus = @import("client_vpn_endpoint_status.zig").ClientVpnEndpointStatus;
const serde = @import("serde.zig");

pub const CreateClientVpnEndpointInput = struct {
    /// Information about the authentication method to be used to authenticate
    /// clients.
    authentication_options: []const ClientVpnAuthenticationRequest,

    /// The IPv4 address range, in CIDR notation, from which to assign client IP
    /// addresses. The address range cannot overlap with the local CIDR of the VPC
    /// in which the associated subnet is located, or the routes that you add
    /// manually. The address range cannot be changed after the Client VPN endpoint
    /// has been created. Client CIDR range must have a size of at least /22 and
    /// must not be greater than /12.
    client_cidr_block: ?[]const u8 = null,

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

    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request.
    /// For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: ?[]const u8 = null,

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
    connection_log_options: ConnectionLogOptions,

    /// A brief description of the Client VPN endpoint.
    description: ?[]const u8 = null,

    /// Indicates whether the client VPN session is disconnected after the maximum
    /// timeout specified in `SessionTimeoutHours` is reached. If `true`, users are
    /// prompted to reconnect client VPN. If `false`, client VPN attempts to
    /// reconnect automatically.
    /// The default value is `true`.
    disconnect_on_session_timeout: ?bool = null,

    /// Information about the DNS servers to be used for DNS resolution. A Client
    /// VPN endpoint can
    /// have up to two DNS servers. If no DNS server is specified, the DNS address
    /// configured on the device is used for the DNS server.
    dns_servers: ?[]const []const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request, and provides an error response. If you have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise, it
    /// is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The IP address type for the Client VPN endpoint. Valid values are `ipv4`
    /// (default) for IPv4 addressing only, `ipv6` for IPv6 addressing only, or
    /// `dual-stack` for both IPv4 and IPv6
    /// addressing. When set to `dual-stack,` clients can connect to the endpoint
    /// using either IPv4 or IPv6 addresses..
    endpoint_ip_address_type: ?EndpointIpAddressType = null,

    /// The IDs of one or more security groups to apply to the target network. You
    /// must also specify the ID of the VPC that contains the security groups.
    security_group_ids: ?[]const []const u8 = null,

    /// Specify whether to enable the self-service portal for the Client VPN
    /// endpoint.
    ///
    /// Default Value: `enabled`
    self_service_portal: ?SelfServicePortal = null,

    /// The ARN of the server certificate. For more information, see
    /// the [Certificate Manager User
    /// Guide](https://docs.aws.amazon.com/acm/latest/userguide/).
    server_certificate_arn: []const u8,

    /// The maximum VPN session duration time in hours.
    ///
    /// Valid values: `8 | 10 | 12 | 24`
    ///
    /// Default value: `24`
    session_timeout_hours: ?i32 = null,

    /// Indicates whether split-tunnel is enabled on the Client VPN endpoint.
    ///
    /// By default, split-tunnel on a VPN endpoint is disabled.
    ///
    /// For information about split-tunnel VPN endpoints, see [Split-tunnel Client
    /// VPN
    /// endpoint](https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/split-tunnel-vpn.html) in the
    /// *Client VPN Administrator Guide*.
    split_tunnel: ?bool = null,

    /// The tags to apply to the Client VPN endpoint during creation.
    tag_specifications: ?[]const TagSpecification = null,

    /// The IP address type for traffic within the Client VPN tunnel. Valid values
    /// are `ipv4` (default) for IPv4 traffic only, `ipv6` for IPv6 addressing only,
    /// or `dual-stack` for both IPv4 and IPv6 traffic. When set to `dual-stack`,
    /// clients can access both IPv4 and IPv6 resources through the VPN .
    traffic_ip_address_type: ?TrafficIpAddressType = null,

    /// The transport protocol to be used by the VPN session.
    ///
    /// Default value: `udp`
    transport_protocol: ?TransportProtocol = null,

    /// The ID of the VPC to associate with the Client VPN endpoint. If no security
    /// group IDs are specified in the request, the default security group for the
    /// VPC is applied.
    vpc_id: ?[]const u8 = null,

    /// The port number to assign to the Client VPN endpoint for TCP and UDP
    /// traffic.
    ///
    /// Valid Values: `443` | `1194`
    ///
    /// Default Value: `443`
    vpn_port: ?i32 = null,
};

pub const CreateClientVpnEndpointOutput = struct {
    /// The ID of the Client VPN endpoint.
    client_vpn_endpoint_id: ?[]const u8 = null,

    /// The DNS name to be used by clients when establishing their VPN session.
    dns_name: ?[]const u8 = null,

    /// The current state of the Client VPN endpoint.
    status: ?ClientVpnEndpointStatus = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateClientVpnEndpointOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateClientVpnEndpointInput, options: Options) !CreateClientVpnEndpointOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateClientVpnEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateClientVpnEndpoint&Version=2016-11-15");
    for (input.authentication_options, 0..) |item, idx| {
        const n = idx + 1;
        if (item.active_directory) |sv_1| {
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Authentication.member.{d}.ActiveDirectory.DirectoryId=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (sv_1.directory_id) |fv_2| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                }
            }
        }
        if (item.federated_authentication) |sv_1| {
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Authentication.member.{d}.FederatedAuthentication.SAMLProviderArn=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (sv_1.saml_provider_arn) |fv_2| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Authentication.member.{d}.FederatedAuthentication.SelfServiceSAMLProviderArn=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (sv_1.self_service_saml_provider_arn) |fv_2| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                }
            }
        }
        if (item.mutual_authentication) |sv_1| {
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Authentication.member.{d}.MutualAuthentication.ClientRootCertificateChainArn=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (sv_1.client_root_certificate_chain_arn) |fv_2| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                }
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Authentication.member.{d}.Type=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            if (item.@"type") |fv_1| {
                try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
            }
        }
    }
    if (input.client_cidr_block) |v| {
        try body_buf.appendSlice(alloc, "&ClientCidrBlock=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.client_connect_options) |v| {
        if (v.enabled) |sv| {
            try body_buf.appendSlice(alloc, "&ClientConnectOptions.Enabled=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.lambda_function_arn) |sv| {
            try body_buf.appendSlice(alloc, "&ClientConnectOptions.LambdaFunctionArn=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.client_login_banner_options) |v| {
        if (v.banner_text) |sv| {
            try body_buf.appendSlice(alloc, "&ClientLoginBannerOptions.BannerText=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.enabled) |sv| {
            try body_buf.appendSlice(alloc, "&ClientLoginBannerOptions.Enabled=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.client_route_enforcement_options) |v| {
        if (v.enforced) |sv| {
            try body_buf.appendSlice(alloc, "&ClientRouteEnforcementOptions.Enforced=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.connection_log_options.cloudwatch_log_group) |sv| {
        try body_buf.appendSlice(alloc, "&ConnectionLogOptions.CloudwatchLogGroup=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.connection_log_options.cloudwatch_log_stream) |sv| {
        try body_buf.appendSlice(alloc, "&ConnectionLogOptions.CloudwatchLogStream=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.connection_log_options.enabled) |sv| {
        try body_buf.appendSlice(alloc, "&ConnectionLogOptions.Enabled=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.disconnect_on_session_timeout) |v| {
        try body_buf.appendSlice(alloc, "&DisconnectOnSessionTimeout=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.dns_servers) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DnsServers.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.endpoint_ip_address_type) |v| {
        try body_buf.appendSlice(alloc, "&EndpointIpAddressType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.security_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecurityGroupId.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.self_service_portal) |v| {
        try body_buf.appendSlice(alloc, "&SelfServicePortal=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    try body_buf.appendSlice(alloc, "&ServerCertificateArn=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.server_certificate_arn);
    if (input.session_timeout_hours) |v| {
        try body_buf.appendSlice(alloc, "&SessionTimeoutHours=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.split_tunnel) |v| {
        try body_buf.appendSlice(alloc, "&SplitTunnel=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    if (input.traffic_ip_address_type) |v| {
        try body_buf.appendSlice(alloc, "&TrafficIpAddressType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.transport_protocol) |v| {
        try body_buf.appendSlice(alloc, "&TransportProtocol=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.vpc_id) |v| {
        try body_buf.appendSlice(alloc, "&VpcId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.vpn_port) |v| {
        try body_buf.appendSlice(alloc, "&VpnPort=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateClientVpnEndpointOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateClientVpnEndpointOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "clientVpnEndpointId")) {
                    result.client_vpn_endpoint_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "dnsName")) {
                    result.dns_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "status")) {
                    result.status = try serde.deserializeClientVpnEndpointStatus(&reader, alloc);
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
