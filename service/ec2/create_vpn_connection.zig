const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const VpnConnectionOptionsSpecification = @import("vpn_connection_options_specification.zig").VpnConnectionOptionsSpecification;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const VpnConnection = @import("vpn_connection.zig").VpnConnection;
const serde = @import("serde.zig");

pub const CreateVpnConnectionInput = struct {
    /// The ID of the customer gateway.
    customer_gateway_id: []const u8,

    /// Checks whether you have the required permissions for the action, without
    /// actually
    /// making the request, and provides an error response. If you have the required
    /// permissions, the error response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The options for the VPN connection.
    options: ?VpnConnectionOptionsSpecification = null,

    /// Specifies the storage mode for the pre-shared key (PSK). Valid values are
    /// `Standard`" (stored in the Site-to-Site VPN service) or `SecretsManager`
    /// (stored in Amazon Web Services Secrets Manager).
    pre_shared_key_storage: ?[]const u8 = null,

    /// The tags to apply to the VPN connection.
    tag_specifications: ?[]const TagSpecification = null,

    /// The ID of the transit gateway. If you specify a transit gateway, you cannot
    /// specify a virtual private
    /// gateway.
    transit_gateway_id: ?[]const u8 = null,

    /// The type of VPN connection (`ipsec.1`).
    @"type": []const u8,

    /// The ID of the VPN concentrator to associate with the VPN connection.
    vpn_concentrator_id: ?[]const u8 = null,

    /// The ID of the virtual private gateway. If you specify a virtual private
    /// gateway, you
    /// cannot specify a transit gateway.
    vpn_gateway_id: ?[]const u8 = null,
};

pub const CreateVpnConnectionOutput = struct {
    /// Information about the VPN connection.
    vpn_connection: ?VpnConnection = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVpnConnectionInput, options: CallOptions) !CreateVpnConnectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVpnConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateVpnConnection&Version=2016-11-15");
    try body_buf.appendSlice(allocator, "&CustomerGatewayId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.customer_gateway_id);
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.options) |v| {
        if (v.enable_acceleration) |sv| {
            try body_buf.appendSlice(allocator, "&Options.EnableAcceleration=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
        if (v.local_ipv_4_network_cidr) |sv| {
            try body_buf.appendSlice(allocator, "&Options.LocalIpv4NetworkCidr=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.local_ipv_6_network_cidr) |sv| {
            try body_buf.appendSlice(allocator, "&Options.LocalIpv6NetworkCidr=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.outside_ip_address_type) |sv| {
            try body_buf.appendSlice(allocator, "&Options.OutsideIpAddressType=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.remote_ipv_4_network_cidr) |sv| {
            try body_buf.appendSlice(allocator, "&Options.RemoteIpv4NetworkCidr=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.remote_ipv_6_network_cidr) |sv| {
            try body_buf.appendSlice(allocator, "&Options.RemoteIpv6NetworkCidr=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.static_routes_only) |sv| {
            try body_buf.appendSlice(allocator, "&Options.StaticRoutesOnly=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
        if (v.transport_transit_gateway_attachment_id) |sv| {
            try body_buf.appendSlice(allocator, "&Options.TransportTransitGatewayAttachmentId=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.tunnel_bandwidth) |sv| {
            try body_buf.appendSlice(allocator, "&Options.TunnelBandwidth=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
        if (v.tunnel_inside_ip_version) |sv| {
            try body_buf.appendSlice(allocator, "&Options.TunnelInsideIpVersion=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
        if (v.tunnel_options) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (item.dpd_timeout_action) |fv_1| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.DPDTimeoutAction=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (item.dpd_timeout_seconds) |fv_1| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.DPDTimeoutSeconds=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (item.enable_tunnel_lifecycle_control) |fv_1| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.EnableTunnelLifecycleControl=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_1) "true" else "false");
                    }
                }
                if (item.ike_versions) |lst_1| {
                    for (lst_1, 0..) |item_1, idx_1| {
                        const n_1 = idx_1 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (item_1.value) |fv_2| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.IKEVersion.{d}.Value=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                            }
                        }
                    }
                }
                if (item.log_options) |sv_1| {
                    if (sv_1.cloud_watch_log_options) |sv_2| {
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.bgp_log_enabled) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.LogOptions.CloudWatchLogOptions.BgpLogEnabled=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_3) "true" else "false");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.bgp_log_group_arn) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.LogOptions.CloudWatchLogOptions.BgpLogGroupArn=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.bgp_log_output_format) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.LogOptions.CloudWatchLogOptions.BgpLogOutputFormat=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.log_enabled) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.LogOptions.CloudWatchLogOptions.LogEnabled=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_3) "true" else "false");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.log_group_arn) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.LogOptions.CloudWatchLogOptions.LogGroupArn=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.log_output_format) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.LogOptions.CloudWatchLogOptions.LogOutputFormat=", .{n}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                    }
                }
                if (item.phase_1_dh_group_numbers) |lst_1| {
                    for (lst_1, 0..) |item_1, idx_1| {
                        const n_1 = idx_1 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (item_1.value) |fv_2| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.Phase1DHGroupNumber.{d}.Value=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                            }
                        }
                    }
                }
                if (item.phase_1_encryption_algorithms) |lst_1| {
                    for (lst_1, 0..) |item_1, idx_1| {
                        const n_1 = idx_1 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (item_1.value) |fv_2| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.Phase1EncryptionAlgorithm.{d}.Value=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                            }
                        }
                    }
                }
                if (item.phase_1_integrity_algorithms) |lst_1| {
                    for (lst_1, 0..) |item_1, idx_1| {
                        const n_1 = idx_1 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (item_1.value) |fv_2| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.Phase1IntegrityAlgorithm.{d}.Value=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                            }
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (item.phase_1_lifetime_seconds) |fv_1| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.Phase1LifetimeSeconds=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                    }
                }
                if (item.phase_2_dh_group_numbers) |lst_1| {
                    for (lst_1, 0..) |item_1, idx_1| {
                        const n_1 = idx_1 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (item_1.value) |fv_2| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.Phase2DHGroupNumber.{d}.Value=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                            }
                        }
                    }
                }
                if (item.phase_2_encryption_algorithms) |lst_1| {
                    for (lst_1, 0..) |item_1, idx_1| {
                        const n_1 = idx_1 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (item_1.value) |fv_2| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.Phase2EncryptionAlgorithm.{d}.Value=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                            }
                        }
                    }
                }
                if (item.phase_2_integrity_algorithms) |lst_1| {
                    for (lst_1, 0..) |item_1, idx_1| {
                        const n_1 = idx_1 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (item_1.value) |fv_2| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.Phase2IntegrityAlgorithm.{d}.Value=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                            }
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (item.phase_2_lifetime_seconds) |fv_1| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.Phase2LifetimeSeconds=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (item.pre_shared_key) |fv_1| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.PreSharedKey=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (item.rekey_fuzz_percentage) |fv_1| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.RekeyFuzzPercentage=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (item.rekey_margin_time_seconds) |fv_1| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.RekeyMarginTimeSeconds=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (item.replay_window_size) |fv_1| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.ReplayWindowSize=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (item.startup_action) |fv_1| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.StartupAction=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (item.tunnel_inside_cidr) |fv_1| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.TunnelInsideCidr=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (item.tunnel_inside_ipv_6_cidr) |fv_1| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TunnelOptions.{d}.TunnelInsideIpv6Cidr=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                    }
                }
            }
        }
    }
    if (input.pre_shared_key_storage) |v| {
        try body_buf.appendSlice(allocator, "&PreSharedKeyStorage=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.resource_type) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.ResourceType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.key) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Key=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.value) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Value=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    if (input.transit_gateway_id) |v| {
        try body_buf.appendSlice(allocator, "&TransitGatewayId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&Type=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.@"type");
    if (input.vpn_concentrator_id) |v| {
        try body_buf.appendSlice(allocator, "&VpnConcentratorId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.vpn_gateway_id) |v| {
        try body_buf.appendSlice(allocator, "&VpnGatewayId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVpnConnectionOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateVpnConnectionOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "vpnConnection")) {
                    result.vpn_connection = try serde.deserializeVpnConnection(allocator, &reader);
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
