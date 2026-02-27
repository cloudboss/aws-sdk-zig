const ImportTableOperationSource = @import("import_table_operation_source.zig").ImportTableOperationSource;

/// A transform operation that imports data from a source table.
pub const ImportTableOperation = struct {
    /// Alias for this operation.
    alias: []const u8,

    /// The source configuration that specifies which source table to import and any
    /// column mappings.
    source: ImportTableOperationSource,

    pub const json_field_names = .{
        .alias = "Alias",
        .source = "Source",
    };
};
