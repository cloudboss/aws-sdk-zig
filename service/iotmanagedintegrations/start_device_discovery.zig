const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DiscoveryAuthMaterialType = @import("discovery_auth_material_type.zig").DiscoveryAuthMaterialType;
const DiscoveryType = @import("discovery_type.zig").DiscoveryType;
const ProtocolType = @import("protocol_type.zig").ProtocolType;

pub const StartDeviceDiscoveryInput = struct {
    /// The identifier of the cloud-to-cloud account association to use for
    /// discovery of third-party devices.
    account_association_id: ?[]const u8 = null,

    /// The authentication material required to start the local device discovery job
    /// request.
    authentication_material: ?[]const u8 = null,

    /// The type of authentication material used for device discovery jobs.
    authentication_material_type: ?DiscoveryAuthMaterialType = null,

    /// An idempotency token. If you retry a request that completed successfully
    /// initially using the same client token and parameters, then the retry attempt
    /// will succeed without performing any further actions.
    client_token: ?[]const u8 = null,

    /// The id of the connector association.
    connector_association_identifier: ?[]const u8 = null,

    /// Used as a filter for PLA discoveries.
    connector_device_id_list: ?[]const []const u8 = null,

    /// The id of the end-user's IoT hub.
    controller_identifier: ?[]const u8 = null,

    /// Additional protocol-specific details required for device discovery, which
    /// vary based on the discovery type.
    ///
    /// For a `DiscoveryType` of `CUSTOM`, the string-to-string map must have a key
    /// value of `Name` set to a non-empty-string.
    custom_protocol_detail: ?[]const aws.map.StringMapEntry = null,

    /// The discovery type supporting the type of device to be discovered in the
    /// device discovery task request.
    discovery_type: DiscoveryType,

    /// The unique id of the end device for capability rediscovery.
    ///
    /// This parameter is only available when the discovery type is
    /// CONTROLLER_CAPABILITY_REDISCOVERY.
    end_device_identifier: ?[]const u8 = null,

    /// The protocol type for capability rediscovery (ZWAVE, ZIGBEE, or CUSTOM).
    ///
    /// This parameter is only available when the discovery type is
    /// CONTROLLER_CAPABILITY_REDISCOVERY.
    protocol: ?ProtocolType = null,

    /// A set of key/value pairs that are used to manage the device discovery
    /// request.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .account_association_id = "AccountAssociationId",
        .authentication_material = "AuthenticationMaterial",
        .authentication_material_type = "AuthenticationMaterialType",
        .client_token = "ClientToken",
        .connector_association_identifier = "ConnectorAssociationIdentifier",
        .connector_device_id_list = "ConnectorDeviceIdList",
        .controller_identifier = "ControllerIdentifier",
        .custom_protocol_detail = "CustomProtocolDetail",
        .discovery_type = "DiscoveryType",
        .end_device_identifier = "EndDeviceIdentifier",
        .protocol = "Protocol",
        .tags = "Tags",
    };
};

pub const StartDeviceDiscoveryOutput = struct {
    /// The id of the device discovery job request.
    id: ?[]const u8 = null,

    /// The timestamp value for the start time of the device discovery.
    started_at: ?i64 = null,

    pub const json_field_names = .{
        .id = "Id",
        .started_at = "StartedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartDeviceDiscoveryInput, options: CallOptions) !StartDeviceDiscoveryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotmanagedintegrations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartDeviceDiscoveryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/device-discoveries";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_association_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AccountAssociationId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.authentication_material) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AuthenticationMaterial\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.authentication_material_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AuthenticationMaterialType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connector_association_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConnectorAssociationIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connector_device_id_list) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConnectorDeviceIdList\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.controller_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ControllerIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.custom_protocol_detail) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CustomProtocolDetail\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DiscoveryType\":");
    try aws.json.writeValue(@TypeOf(input.discovery_type), input.discovery_type, allocator, &body_buf);
    has_prev = true;
    if (input.end_device_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EndDeviceIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.protocol) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Protocol\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartDeviceDiscoveryOutput {
    const result: StartDeviceDiscoveryOutput = try aws.json.parseJsonObject(
        StartDeviceDiscoveryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
