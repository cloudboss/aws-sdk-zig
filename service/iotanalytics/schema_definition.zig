const Column = @import("column.zig").Column;

/// Information needed to define a schema.
pub const SchemaDefinition = struct {
    /// Specifies one or more columns that store your data.
    ///
    /// Each schema can have up to 100 columns. Each column can have up to 100
    /// nested
    /// types.
    columns: ?[]const Column = null,

    pub const json_field_names = .{
        .columns = "columns",
    };
};
