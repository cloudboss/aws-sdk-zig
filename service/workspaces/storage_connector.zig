const StorageConnectorTypeEnum = @import("storage_connector_type_enum.zig").StorageConnectorTypeEnum;
const StorageConnectorStatusEnum = @import("storage_connector_status_enum.zig").StorageConnectorStatusEnum;

/// Describes the storage connector.
pub const StorageConnector = struct {
    /// The type of connector used to save user files.
    connector_type: StorageConnectorTypeEnum,

    /// Indicates if the storage connetor is enabled or disabled.
    status: StorageConnectorStatusEnum,

    pub const json_field_names = .{
        .connector_type = "ConnectorType",
        .status = "Status",
    };
};
