const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapabilityReport = @import("capability_report.zig").CapabilityReport;
const CapabilitySchemaItem = @import("capability_schema_item.zig").CapabilitySchemaItem;
const HubNetworkMode = @import("hub_network_mode.zig").HubNetworkMode;
const WiFiSimpleSetupConfiguration = @import("wi_fi_simple_setup_configuration.zig").WiFiSimpleSetupConfiguration;

pub const UpdateManagedThingInput = struct {
    /// The brand of the device.
    brand: ?[]const u8 = null,

    /// The capabilities of the device such as light bulb.
    capabilities: ?[]const u8 = null,

    /// A report of the capabilities for the managed thing.
    capability_report: ?CapabilityReport = null,

    /// The updated capability schemas that define the functionality and features
    /// supported by the managed thing.
    capability_schemas: ?[]const CapabilitySchemaItem = null,

    /// The classification of the managed thing such as light bulb or thermostat.
    classification: ?[]const u8 = null,

    /// The identifier of the credential for the managed thing.
    credential_locker_id: ?[]const u8 = null,

    /// The network mode for the hub-connected device.
    hub_network_mode: ?HubNetworkMode = null,

    /// The id of the managed thing.
    identifier: []const u8,

    /// The metadata for the managed thing.
    meta_data: ?[]const aws.map.StringMapEntry = null,

    /// The model of the device.
    model: ?[]const u8 = null,

    /// The name of the managed thing representing the physical device.
    name: ?[]const u8 = null,

    /// Owner of the device, usually an indication of whom the device belongs to.
    /// This value should not contain personal identifiable information.
    owner: ?[]const u8 = null,

    /// The serial number of the device.
    serial_number: ?[]const u8 = null,

    /// The Wi-Fi Simple Setup configuration for the managed thing, which defines
    /// provisioning capabilities and timeout settings.
    wi_fi_simple_setup_configuration: ?WiFiSimpleSetupConfiguration = null,

    pub const json_field_names = .{
        .brand = "Brand",
        .capabilities = "Capabilities",
        .capability_report = "CapabilityReport",
        .capability_schemas = "CapabilitySchemas",
        .classification = "Classification",
        .credential_locker_id = "CredentialLockerId",
        .hub_network_mode = "HubNetworkMode",
        .identifier = "Identifier",
        .meta_data = "MetaData",
        .model = "Model",
        .name = "Name",
        .owner = "Owner",
        .serial_number = "SerialNumber",
        .wi_fi_simple_setup_configuration = "WiFiSimpleSetupConfiguration",
    };
};

pub const UpdateManagedThingOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateManagedThingInput, options: CallOptions) !UpdateManagedThingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateManagedThingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/managed-things/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.brand) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Brand\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.capabilities) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Capabilities\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.capability_report) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CapabilityReport\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.capability_schemas) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CapabilitySchemas\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.classification) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Classification\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.credential_locker_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CredentialLockerId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.hub_network_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"HubNetworkMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.meta_data) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MetaData\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.model) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Model\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.owner) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Owner\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.serial_number) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SerialNumber\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.wi_fi_simple_setup_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"WiFiSimpleSetupConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateManagedThingOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateManagedThingOutput = .{};

    return result;
}
