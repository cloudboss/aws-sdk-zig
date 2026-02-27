const ConnectorProvisioningType = @import("connector_provisioning_type.zig").ConnectorProvisioningType;
const ConnectorType = @import("connector_type.zig").ConnectorType;
const SupportedDataTransferType = @import("supported_data_transfer_type.zig").SupportedDataTransferType;

/// Information about the registered connector.
pub const ConnectorDetail = struct {
    /// The application type of the connector.
    application_type: ?[]const u8,

    /// A description about the registered connector.
    connector_description: ?[]const u8,

    /// A label used for the connector.
    connector_label: ?[]const u8,

    /// The connection mode that the connector supports.
    connector_modes: ?[]const []const u8,

    /// The name of the connector.
    connector_name: ?[]const u8,

    /// The owner of the connector.
    connector_owner: ?[]const u8,

    /// The provisioning type that the connector uses.
    connector_provisioning_type: ?ConnectorProvisioningType,

    /// The connector type.
    connector_type: ?ConnectorType,

    /// The connector version.
    connector_version: ?[]const u8,

    /// The time at which the connector was registered.
    registered_at: ?i64,

    /// The user who registered the connector.
    registered_by: ?[]const u8,

    /// The data transfer types that the connector supports.
    ///
    /// **RECORD**
    ///
    /// Structured records.
    ///
    /// **FILE**
    ///
    /// Files or binary data.
    supported_data_transfer_types: ?[]const SupportedDataTransferType,

    pub const json_field_names = .{
        .application_type = "applicationType",
        .connector_description = "connectorDescription",
        .connector_label = "connectorLabel",
        .connector_modes = "connectorModes",
        .connector_name = "connectorName",
        .connector_owner = "connectorOwner",
        .connector_provisioning_type = "connectorProvisioningType",
        .connector_type = "connectorType",
        .connector_version = "connectorVersion",
        .registered_at = "registeredAt",
        .registered_by = "registeredBy",
        .supported_data_transfer_types = "supportedDataTransferTypes",
    };
};
