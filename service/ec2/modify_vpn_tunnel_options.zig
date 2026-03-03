const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ModifyVpnTunnelOptionsSpecification = @import("modify_vpn_tunnel_options_specification.zig").ModifyVpnTunnelOptionsSpecification;
const VpnConnection = @import("vpn_connection.zig").VpnConnection;
const serde = @import("serde.zig");

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
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyVpnTunnelOptionsInput, options: CallOptions) !ModifyVpnTunnelOptionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyVpnTunnelOptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ModifyVpnTunnelOptions&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.pre_shared_key_storage) |v| {
        try body_buf.appendSlice(allocator, "&PreSharedKeyStorage=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.skip_tunnel_replacement) |v| {
        try body_buf.appendSlice(allocator, "&SkipTunnelReplacement=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.tunnel_options.dpd_timeout_action) |sv| {
        try body_buf.appendSlice(allocator, "&TunnelOptions.DPDTimeoutAction=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
    }
    if (input.tunnel_options.dpd_timeout_seconds) |sv| {
        try body_buf.appendSlice(allocator, "&TunnelOptions.DPDTimeoutSeconds=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
    }
    if (input.tunnel_options.enable_tunnel_lifecycle_control) |sv| {
        try body_buf.appendSlice(allocator, "&TunnelOptions.EnableTunnelLifecycleControl=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
    }
    if (input.tunnel_options.ike_versions) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TunnelOptions.IKEVersions.item.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.value) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.tunnel_options.log_options) |sv| {
        if (sv.cloud_watch_log_options) |sv2| {
            if (sv2.bgp_log_enabled) |sv3| {
                try body_buf.appendSlice(allocator, "&TunnelOptions.LogOptions.CloudWatchLogOptions.BgpLogEnabled=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv3) "true" else "false");
            }
            if (sv2.bgp_log_group_arn) |sv3| {
                try body_buf.appendSlice(allocator, "&TunnelOptions.LogOptions.CloudWatchLogOptions.BgpLogGroupArn=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv3);
            }
            if (sv2.bgp_log_output_format) |sv3| {
                try body_buf.appendSlice(allocator, "&TunnelOptions.LogOptions.CloudWatchLogOptions.BgpLogOutputFormat=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv3);
            }
            if (sv2.log_enabled) |sv3| {
                try body_buf.appendSlice(allocator, "&TunnelOptions.LogOptions.CloudWatchLogOptions.LogEnabled=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv3) "true" else "false");
            }
            if (sv2.log_group_arn) |sv3| {
                try body_buf.appendSlice(allocator, "&TunnelOptions.LogOptions.CloudWatchLogOptions.LogGroupArn=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv3);
            }
            if (sv2.log_output_format) |sv3| {
                try body_buf.appendSlice(allocator, "&TunnelOptions.LogOptions.CloudWatchLogOptions.LogOutputFormat=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv3);
            }
        }
    }
    if (input.tunnel_options.phase_1_dh_group_numbers) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TunnelOptions.Phase1DHGroupNumbers.item.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.value) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
        }
    }
    if (input.tunnel_options.phase_1_encryption_algorithms) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TunnelOptions.Phase1EncryptionAlgorithms.item.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.value) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.tunnel_options.phase_1_integrity_algorithms) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TunnelOptions.Phase1IntegrityAlgorithms.item.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.value) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.tunnel_options.phase_1_lifetime_seconds) |sv| {
        try body_buf.appendSlice(allocator, "&TunnelOptions.Phase1LifetimeSeconds=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
    }
    if (input.tunnel_options.phase_2_dh_group_numbers) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TunnelOptions.Phase2DHGroupNumbers.item.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.value) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
        }
    }
    if (input.tunnel_options.phase_2_encryption_algorithms) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TunnelOptions.Phase2EncryptionAlgorithms.item.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.value) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.tunnel_options.phase_2_integrity_algorithms) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TunnelOptions.Phase2IntegrityAlgorithms.item.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.value) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.tunnel_options.phase_2_lifetime_seconds) |sv| {
        try body_buf.appendSlice(allocator, "&TunnelOptions.Phase2LifetimeSeconds=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
    }
    if (input.tunnel_options.pre_shared_key) |sv| {
        try body_buf.appendSlice(allocator, "&TunnelOptions.PreSharedKey=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
    }
    if (input.tunnel_options.rekey_fuzz_percentage) |sv| {
        try body_buf.appendSlice(allocator, "&TunnelOptions.RekeyFuzzPercentage=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
    }
    if (input.tunnel_options.rekey_margin_time_seconds) |sv| {
        try body_buf.appendSlice(allocator, "&TunnelOptions.RekeyMarginTimeSeconds=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
    }
    if (input.tunnel_options.replay_window_size) |sv| {
        try body_buf.appendSlice(allocator, "&TunnelOptions.ReplayWindowSize=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
    }
    if (input.tunnel_options.startup_action) |sv| {
        try body_buf.appendSlice(allocator, "&TunnelOptions.StartupAction=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
    }
    if (input.tunnel_options.tunnel_inside_cidr) |sv| {
        try body_buf.appendSlice(allocator, "&TunnelOptions.TunnelInsideCidr=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
    }
    if (input.tunnel_options.tunnel_inside_ipv_6_cidr) |sv| {
        try body_buf.appendSlice(allocator, "&TunnelOptions.TunnelInsideIpv6Cidr=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
    }
    try body_buf.appendSlice(allocator, "&VpnConnectionId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.vpn_connection_id);
    try body_buf.appendSlice(allocator, "&VpnTunnelOutsideIpAddress=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.vpn_tunnel_outside_ip_address);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyVpnTunnelOptionsOutput {
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
