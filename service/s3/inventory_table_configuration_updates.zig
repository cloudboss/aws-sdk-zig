const InventoryConfigurationState = @import("inventory_configuration_state.zig").InventoryConfigurationState;
const MetadataTableEncryptionConfiguration = @import("metadata_table_encryption_configuration.zig").MetadataTableEncryptionConfiguration;

/// The specified updates to the S3 Metadata inventory table configuration.
pub const InventoryTableConfigurationUpdates = struct {
    /// The configuration state of the inventory table, indicating whether the
    /// inventory table is enabled
    /// or disabled.
    configuration_state: InventoryConfigurationState,

    /// The encryption configuration for the inventory table.
    encryption_configuration: ?MetadataTableEncryptionConfiguration = null,
};
