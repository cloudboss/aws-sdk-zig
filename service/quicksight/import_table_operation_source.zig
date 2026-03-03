const DataSetColumnIdMapping = @import("data_set_column_id_mapping.zig").DataSetColumnIdMapping;

/// Specifies the source table and column mappings for an import table
/// operation.
pub const ImportTableOperationSource = struct {
    /// The mappings between source column identifiers and target column identifiers
    /// during the import.
    column_id_mappings: ?[]const DataSetColumnIdMapping = null,

    /// The identifier of the source table to import data from.
    source_table_id: []const u8,

    pub const json_field_names = .{
        .column_id_mappings = "ColumnIdMappings",
        .source_table_id = "SourceTableId",
    };
};
