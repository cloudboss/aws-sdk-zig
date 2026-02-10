const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

/// Download an Amazon Web Services-provided sample configuration file to be
/// used with the customer
/// gateway device specified for your Site-to-Site VPN connection.
pub const GetVpnConnectionDeviceSampleConfigurationInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually
    /// making the request, and provides an error response. If you have the required
    /// permissions, the error response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The IKE version to be used in the sample configuration file for your
    /// customer gateway
    /// device. You can specify one of the following versions: `ikev1` or
    /// `ikev2`.
    internet_key_exchange_version: ?[]const u8 = null,

    /// The type of sample configuration to generate. Valid values are
    /// "compatibility" (includes IKEv1) or "recommended" (throws
    /// UnsupportedOperationException for IKEv1).
    sample_type: ?[]const u8 = null,

    /// Device identifier provided by the `GetVpnConnectionDeviceTypes` API.
    vpn_connection_device_type_id: []const u8,

    /// The `VpnConnectionId` specifies the Site-to-Site VPN connection used for the
    /// sample
    /// configuration.
    vpn_connection_id: []const u8,
};

pub const GetVpnConnectionDeviceSampleConfigurationOutput = struct {
    /// Sample configuration file for the specified customer gateway device.
    vpn_connection_device_sample_configuration: ?[]const u8 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const GetVpnConnectionDeviceSampleConfigurationOutput) void {
        if (self.vpn_connection_device_sample_configuration) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: GetVpnConnectionDeviceSampleConfigurationInput, options: Options) !GetVpnConnectionDeviceSampleConfigurationOutput {
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

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetVpnConnectionDeviceSampleConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=GetVpnConnectionDeviceSampleConfiguration&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.internet_key_exchange_version) |v| {
        try body_buf.appendSlice(alloc, "&InternetKeyExchangeVersion=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.sample_type) |v| {
        try body_buf.appendSlice(alloc, "&SampleType=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&VpnConnectionDeviceTypeId=");
    try appendUrlEncoded(alloc, &body_buf, input.vpn_connection_device_type_id);
    try body_buf.appendSlice(alloc, "&VpnConnectionId=");
    try appendUrlEncoded(alloc, &body_buf, input.vpn_connection_id);

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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !GetVpnConnectionDeviceSampleConfigurationOutput {
    _ = status;
    var result: GetVpnConnectionDeviceSampleConfigurationOutput = .{ .allocator = alloc };
    if (findElement(body, "vpnConnectionDeviceSampleConfiguration")) |content| {
        result.vpn_connection_device_sample_configuration = try alloc.dupe(u8, content);
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
