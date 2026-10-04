const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HubNetworkMode = @import("hub_network_mode.zig").HubNetworkMode;
const ProvisioningStatus = @import("provisioning_status.zig").ProvisioningStatus;
const Role = @import("role.zig").Role;
const WiFiSimpleSetupConfiguration = @import("wi_fi_simple_setup_configuration.zig").WiFiSimpleSetupConfiguration;

pub const GetManagedThingInput = struct {
    /// The id of the managed thing.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};

pub const GetManagedThingOutput = struct {
    /// The timestampe value of when the device was activated.
    activated_at: ?i64 = null,

    /// The id of the advertised product.
    advertised_product_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the managed thing.
    arn: ?[]const u8 = null,

    /// The brand of the device.
    brand: ?[]const u8 = null,

    /// The classification of the managed thing such as light bulb or thermostat.
    classification: ?[]const u8 = null,

    /// The identifier of the connector destination associated with this managed
    /// thing.
    connector_destination_id: ?[]const u8 = null,

    /// The third-party device id as defined by the connector. This device id must
    /// not contain personal identifiable information (PII).
    ///
    /// This parameter is used for cloud-to-cloud devices only.
    connector_device_id: ?[]const u8 = null,

    /// The id of the connector policy.
    ///
    /// This parameter is used for cloud-to-cloud devices only.
    connector_policy_id: ?[]const u8 = null,

    /// The timestamp value of when the device creation request occurred.
    created_at: ?i64 = null,

    /// The identifier of the credential locker for the managed thing.
    credential_locker_id: ?[]const u8 = null,

    /// A Zwave device-specific key used during device activation.
    ///
    /// This parameter is used for Zwave devices only.
    device_specific_key: ?[]const u8 = null,

    /// The network mode for the hub-connected device.
    hub_network_mode: ?HubNetworkMode = null,

    /// The id of the managed thing.
    id: ?[]const u8 = null,

    /// The unique 13 digit number that identifies the managed thing.
    international_article_number: ?[]const u8 = null,

    /// The media access control (MAC) address for the device represented by the
    /// managed thing.
    ///
    /// This parameter is used for Zigbee devices only.
    mac_address: ?[]const u8 = null,

    /// The metadata for the managed thing.
    meta_data: ?[]const aws.map.StringMapEntry = null,

    /// The model of the device.
    model: ?[]const u8 = null,

    /// The name of the managed thing representing the physical device.
    name: ?[]const u8 = null,

    /// Owner of the device, usually an indication of whom the device belongs to.
    /// This value should not contain personal identifiable information.
    owner: ?[]const u8 = null,

    /// Id of the controller device used for the discovery job.
    parent_controller_id: ?[]const u8 = null,

    /// The provisioning status of the device in the provisioning workflow for
    /// onboarding to IoT managed integrations. For more information, see [Device
    /// Provisioning](https://docs.aws.amazon.com/iot-mi/latest/devguide/device-provisioning.html).
    provisioning_status: ?ProvisioningStatus = null,

    /// The type of device used. This will be the Amazon Web Services hub
    /// controller, cloud device, or IoT device.
    role: ?Role = null,

    /// The serial number of the device.
    serial_number: ?[]const u8 = null,

    /// A set of key/value pairs that are used to manage the managed thing.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The universal product code (UPC) of the device model. The UPC is typically
    /// used in the United States of America and Canada.
    universal_product_code: ?[]const u8 = null,

    /// The timestamp value of when the managed thing was last updated at.
    updated_at: ?i64 = null,

    /// The Wi-Fi Simple Setup configuration for the managed thing, which defines
    /// provisioning capabilities and timeout settings.
    wi_fi_simple_setup_configuration: ?WiFiSimpleSetupConfiguration = null,

    pub const json_field_names = .{
        .activated_at = "ActivatedAt",
        .advertised_product_id = "AdvertisedProductId",
        .arn = "Arn",
        .brand = "Brand",
        .classification = "Classification",
        .connector_destination_id = "ConnectorDestinationId",
        .connector_device_id = "ConnectorDeviceId",
        .connector_policy_id = "ConnectorPolicyId",
        .created_at = "CreatedAt",
        .credential_locker_id = "CredentialLockerId",
        .device_specific_key = "DeviceSpecificKey",
        .hub_network_mode = "HubNetworkMode",
        .id = "Id",
        .international_article_number = "InternationalArticleNumber",
        .mac_address = "MacAddress",
        .meta_data = "MetaData",
        .model = "Model",
        .name = "Name",
        .owner = "Owner",
        .parent_controller_id = "ParentControllerId",
        .provisioning_status = "ProvisioningStatus",
        .role = "Role",
        .serial_number = "SerialNumber",
        .tags = "Tags",
        .universal_product_code = "UniversalProductCode",
        .updated_at = "UpdatedAt",
        .wi_fi_simple_setup_configuration = "WiFiSimpleSetupConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetManagedThingInput, options: CallOptions) !GetManagedThingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetManagedThingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/managed-things/");
    try path_buf.appendSlice(allocator, input.identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetManagedThingOutput {
    var result: GetManagedThingOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetManagedThingOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
