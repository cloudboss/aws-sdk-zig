const DiscoveryModification = @import("discovery_modification.zig").DiscoveryModification;

/// Structure containing summary information about a device discovered during a
/// device discovery job.
pub const DiscoveredDeviceSummary = struct {
    /// The authentication material required for connecting to the discovered
    /// device, such as credentials or tokens.
    authentication_material: ?[]const u8,

    /// The brand of the discovered device.
    brand: ?[]const u8,

    /// The third-party device identifier as defined by the connector. This
    /// identifier must not contain personal identifiable information (PII).
    connector_device_id: ?[]const u8,

    /// The name of the device as defined by the connector or third-party system.
    connector_device_name: ?[]const u8,

    /// The list of device types or categories that the discovered device belongs
    /// to.
    device_types: ?[]const []const u8,

    /// The timestamp indicating when the device was discovered.
    discovered_at: ?i64,

    /// The identifier of the managed thing created for this discovered device, if
    /// one exists.
    managed_thing_id: ?[]const u8,

    /// The model of the discovered device.
    model: ?[]const u8,

    /// The status of the discovered device, indicating whether it has been added,
    /// removed, or modified since the last discovery.
    modification: ?DiscoveryModification,

    pub const json_field_names = .{
        .authentication_material = "AuthenticationMaterial",
        .brand = "Brand",
        .connector_device_id = "ConnectorDeviceId",
        .connector_device_name = "ConnectorDeviceName",
        .device_types = "DeviceTypes",
        .discovered_at = "DiscoveredAt",
        .managed_thing_id = "ManagedThingId",
        .model = "Model",
        .modification = "Modification",
    };
};
