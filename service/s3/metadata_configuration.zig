const AnnotationTableConfiguration = @import("annotation_table_configuration.zig").AnnotationTableConfiguration;
const InventoryTableConfiguration = @import("inventory_table_configuration.zig").InventoryTableConfiguration;
const JournalTableConfiguration = @import("journal_table_configuration.zig").JournalTableConfiguration;

/// The S3 Metadata configuration for a general purpose bucket.
pub const MetadataConfiguration = struct {
    /// Optional annotation table configuration to include with the metadata
    /// configuration.
    annotation_table_configuration: ?AnnotationTableConfiguration = null,

    /// The inventory table configuration for a metadata configuration.
    inventory_table_configuration: ?InventoryTableConfiguration = null,

    /// The journal table configuration for a metadata configuration.
    journal_table_configuration: JournalTableConfiguration,
};
