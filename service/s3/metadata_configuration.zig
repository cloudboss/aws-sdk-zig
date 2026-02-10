const InventoryTableConfiguration = @import("inventory_table_configuration.zig").InventoryTableConfiguration;
const JournalTableConfiguration = @import("journal_table_configuration.zig").JournalTableConfiguration;

/// The S3 Metadata configuration for a general purpose bucket.
pub const MetadataConfiguration = struct {
    /// The inventory table configuration for a metadata configuration.
    inventory_table_configuration: ?InventoryTableConfiguration,

    /// The journal table configuration for a metadata configuration.
    journal_table_configuration: JournalTableConfiguration,
};
