const MatterCapabilityReport = @import("matter_capability_report.zig").MatterCapabilityReport;
const CapabilitySchemaItem = @import("capability_schema_item.zig").CapabilitySchemaItem;

/// Describe the device using the relevant metadata and supported clusters for
/// device discovery.
pub const Device = struct {
    /// The capability report for the device.
    capability_report: MatterCapabilityReport,

    /// Report of all capabilities supported by the device.
    capability_schemas: ?[]const CapabilitySchemaItem = null,

    /// The device id as defined by the connector.
    ///
    /// This parameter is used for cloud-to-cloud devices only.
    connector_device_id: []const u8,

    /// The name of the device as defined by the connector.
    connector_device_name: ?[]const u8 = null,

    /// The metadata attributes for a device.
    device_metadata: ?[]const u8 = null,

    pub const json_field_names = .{
        .capability_report = "CapabilityReport",
        .capability_schemas = "CapabilitySchemas",
        .connector_device_id = "ConnectorDeviceId",
        .connector_device_name = "ConnectorDeviceName",
        .device_metadata = "DeviceMetadata",
    };
};
