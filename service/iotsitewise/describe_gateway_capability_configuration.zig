const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapabilitySyncStatus = @import("capability_sync_status.zig").CapabilitySyncStatus;

pub const DescribeGatewayCapabilityConfigurationInput = struct {
    /// The namespace of the capability configuration.
    /// For example, if you configure OPC UA
    /// sources for an MQTT-enabled gateway, your OPC-UA capability configuration
    /// has the namespace
    /// `iotsitewise:opcuacollector:3`.
    capability_namespace: []const u8,

    /// The ID of the gateway that defines the capability configuration.
    gateway_id: []const u8,

    pub const json_field_names = .{
        .capability_namespace = "capabilityNamespace",
        .gateway_id = "gatewayId",
    };
};

pub const DescribeGatewayCapabilityConfigurationOutput = struct {
    /// The JSON document that defines the gateway capability's configuration. For
    /// more
    /// information, see [Configuring data sources
    /// (CLI)](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/configure-sources.html#configure-source-cli) in the *IoT SiteWise User Guide*.
    capability_configuration: []const u8,

    /// The namespace of the gateway capability.
    capability_namespace: []const u8,

    /// The synchronization status of the gateway capability configuration. The sync
    /// status can be one of the following:
    ///
    /// * `IN_SYNC` - The gateway is running with the latest configuration.
    ///
    /// * `OUT_OF_SYNC` - The gateway hasn't received the latest configuration.
    ///
    /// * `SYNC_FAILED` - The gateway rejected the latest configuration.
    ///
    /// * `UNKNOWN` - The gateway hasn't reported its sync status.
    ///
    /// * `NOT_APPLICABLE` - The gateway doesn't support this capability. This is
    ///   most common when integrating partner data sources, because the data
    ///   integration is handled externally by the partner.
    capability_sync_status: CapabilitySyncStatus,

    /// The ID of the gateway that defines the capability configuration.
    gateway_id: []const u8,

    pub const json_field_names = .{
        .capability_configuration = "capabilityConfiguration",
        .capability_namespace = "capabilityNamespace",
        .capability_sync_status = "capabilitySyncStatus",
        .gateway_id = "gatewayId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeGatewayCapabilityConfigurationInput, options: CallOptions) !DescribeGatewayCapabilityConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeGatewayCapabilityConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/20200301/gateways/");
    try path_buf.appendSlice(allocator, input.gateway_id);
    try path_buf.appendSlice(allocator, "/capability/");
    try path_buf.appendSlice(allocator, input.capability_namespace);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeGatewayCapabilityConfigurationOutput {
    var result: DescribeGatewayCapabilityConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeGatewayCapabilityConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
