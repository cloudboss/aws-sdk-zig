const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *GetVpnConnectionDeviceSampleConfigurationOutput) void {
        self._arena.deinit();
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

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetVpnConnectionDeviceSampleConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=GetVpnConnectionDeviceSampleConfiguration&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.internet_key_exchange_version) |v| {
        try body_buf.appendSlice(alloc, "&InternetKeyExchangeVersion=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.sample_type) |v| {
        try body_buf.appendSlice(alloc, "&SampleType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&VpnConnectionDeviceTypeId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.vpn_connection_device_type_id);
    try body_buf.appendSlice(alloc, "&VpnConnectionId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.vpn_connection_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetVpnConnectionDeviceSampleConfigurationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: GetVpnConnectionDeviceSampleConfigurationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "vpnConnectionDeviceSampleConfiguration")) {
                    result.vpn_connection_device_sample_configuration = try alloc.dupe(u8, try reader.readElementText());
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
