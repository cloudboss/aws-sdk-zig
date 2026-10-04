const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthMaterialType = @import("auth_material_type.zig").AuthMaterialType;
const CapabilityReport = @import("capability_report.zig").CapabilityReport;
const CapabilitySchemaItem = @import("capability_schema_item.zig").CapabilitySchemaItem;
const Role = @import("role.zig").Role;
const WiFiSimpleSetupConfiguration = @import("wi_fi_simple_setup_configuration.zig").WiFiSimpleSetupConfiguration;

pub const CreateManagedThingInput = struct {
    /// The authentication material defining the device connectivity setup requests.
    /// The authorization materials used are the device bar code.
    authentication_material: []const u8,

    /// The type of authentication material used for device connectivity setup
    /// requests.
    authentication_material_type: AuthMaterialType,

    /// The brand of the device.
    brand: ?[]const u8 = null,

    /// The capabilities of the device such as light bulb.
    capabilities: ?[]const u8 = null,

    /// A report of the capabilities for the managed thing.
    capability_report: ?CapabilityReport = null,

    /// The capability schemas that define the functionality and features supported
    /// by the managed thing, including device capabilities and their associated
    /// properties.
    capability_schemas: ?[]const CapabilitySchemaItem = null,

    /// The classification of the managed thing such as light bulb or thermostat.
    classification: ?[]const u8 = null,

    /// An idempotency token. If you retry a request that completed successfully
    /// initially using the same client token and parameters, then the retry attempt
    /// will succeed without performing any further actions.
    client_token: ?[]const u8 = null,

    /// The identifier of the credential for the managed thing.
    credential_locker_id: ?[]const u8 = null,

    /// The metadata for the managed thing.
    ///
    /// The `managedThing` `metadata` parameter is used for associating attributes
    /// with a `managedThing` that can be used for grouping over-the-air (OTA)
    /// tasks. Name value pairs in `metadata` can be used in the
    /// `OtaTargetQueryString` parameter for the `CreateOtaTask` API operation.
    meta_data: ?[]const aws.map.StringMapEntry = null,

    /// The model of the device.
    model: ?[]const u8 = null,

    /// The name of the managed thing representing the physical device.
    name: ?[]const u8 = null,

    /// Owner of the device, usually an indication of whom the device belongs to.
    /// This value should not contain personal identifiable information.
    owner: ?[]const u8 = null,

    /// The type of device used. This will be the hub controller, cloud device, or
    /// AWS IoT device.
    role: Role,

    /// The serial number of the device.
    serial_number: ?[]const u8 = null,

    /// A set of key/value pairs that are used to manage the managed thing.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The Wi-Fi Simple Setup configuration for the managed thing, which defines
    /// provisioning capabilities and timeout settings.
    wi_fi_simple_setup_configuration: ?WiFiSimpleSetupConfiguration = null,

    pub const json_field_names = .{
        .authentication_material = "AuthenticationMaterial",
        .authentication_material_type = "AuthenticationMaterialType",
        .brand = "Brand",
        .capabilities = "Capabilities",
        .capability_report = "CapabilityReport",
        .capability_schemas = "CapabilitySchemas",
        .classification = "Classification",
        .client_token = "ClientToken",
        .credential_locker_id = "CredentialLockerId",
        .meta_data = "MetaData",
        .model = "Model",
        .name = "Name",
        .owner = "Owner",
        .role = "Role",
        .serial_number = "SerialNumber",
        .tags = "Tags",
        .wi_fi_simple_setup_configuration = "WiFiSimpleSetupConfiguration",
    };
};

pub const CreateManagedThingOutput = struct {
    /// The Amazon Resource Name (ARN) of the managed thing.
    arn: ?[]const u8 = null,

    /// The timestamp value of when the device creation request occurred.
    created_at: ?i64 = null,

    /// The id of the managed thing.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .id = "Id",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateManagedThingInput, options: CallOptions) !CreateManagedThingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateManagedThingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/managed-things";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AuthenticationMaterial\":");
    try aws.json.writeValue(@TypeOf(input.authentication_material), input.authentication_material, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AuthenticationMaterialType\":");
    try aws.json.writeValue(@TypeOf(input.authentication_material_type), input.authentication_material_type, allocator, &body_buf);
    has_prev = true;
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
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.credential_locker_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CredentialLockerId\":");
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Role\":");
    try aws.json.writeValue(@TypeOf(input.role), input.role, allocator, &body_buf);
    has_prev = true;
    if (input.serial_number) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SerialNumber\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateManagedThingOutput {
    const result: CreateManagedThingOutput = try aws.json.parseJsonObject(
        CreateManagedThingOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
