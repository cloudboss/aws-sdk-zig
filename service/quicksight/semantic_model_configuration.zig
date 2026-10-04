const aws = @import("aws");

const DataSetSemanticMetadata = @import("data_set_semantic_metadata.zig").DataSetSemanticMetadata;
const SemanticTable = @import("semantic_table.zig").SemanticTable;

/// Configuration for the semantic model that defines how prepared data is
/// structured for analysis and reporting.
pub const SemanticModelConfiguration = struct {
    /// The dataset-level semantic metadata, including a description and custom
    /// instructions.
    semantic_metadata: ?[]const DataSetSemanticMetadata = null,

    /// A map of semantic tables that define the analytical structure.
    table_map: ?[]const aws.map.MapEntry(SemanticTable) = null,

    pub const json_field_names = .{
        .semantic_metadata = "SemanticMetadata",
        .table_map = "TableMap",
    };
};
