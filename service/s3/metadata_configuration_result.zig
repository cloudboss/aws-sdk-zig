const DestinationResult = @import("destination_result.zig").DestinationResult;
const InventoryTableConfigurationResult = @import("inventory_table_configuration_result.zig").InventoryTableConfigurationResult;
const JournalTableConfigurationResult = @import("journal_table_configuration_result.zig").JournalTableConfigurationResult;

/// The S3 Metadata configuration for a general purpose bucket.
pub const MetadataConfigurationResult = struct {
    /// The destination settings for a metadata configuration.
    destination_result: DestinationResult,

    /// The inventory table configuration for a metadata configuration.
    inventory_table_configuration_result: ?InventoryTableConfigurationResult = null,

    /// The journal table configuration for a metadata configuration.
    journal_table_configuration_result: ?JournalTableConfigurationResult = null,
};
