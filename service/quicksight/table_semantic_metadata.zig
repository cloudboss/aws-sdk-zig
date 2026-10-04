const SharedColumnSemanticMetadata = @import("shared_column_semantic_metadata.zig").SharedColumnSemanticMetadata;

/// Column-level semantic metadata for a semantic table.
pub const TableSemanticMetadata = struct {
    /// A list of column semantic metadata entries.
    column_metadata: ?[]const SharedColumnSemanticMetadata = null,

    pub const json_field_names = .{
        .column_metadata = "ColumnMetadata",
    };
};
