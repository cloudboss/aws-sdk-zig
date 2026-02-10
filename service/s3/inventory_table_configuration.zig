const InventoryConfigurationState = @import("inventory_configuration_state.zig").InventoryConfigurationState;
const MetadataTableEncryptionConfiguration = @import("metadata_table_encryption_configuration.zig").MetadataTableEncryptionConfiguration;

/// The inventory table configuration for an S3 Metadata configuration.
pub const InventoryTableConfiguration = struct {
    /// The configuration state of the inventory table, indicating whether the
    /// inventory table is enabled
    /// or disabled.
    configuration_state: InventoryConfigurationState,

    /// The encryption configuration for the inventory table.
    encryption_configuration: ?MetadataTableEncryptionConfiguration,
};
