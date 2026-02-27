const GlueStudioSchemaColumn = @import("glue_studio_schema_column.zig").GlueStudioSchemaColumn;

/// Specifies a user-defined schema when a schema cannot be determined by Glue.
pub const GlueSchema = struct {
    /// Specifies the column definitions that make up a Glue schema.
    columns: ?[]const GlueStudioSchemaColumn,

    pub const json_field_names = .{
        .columns = "Columns",
    };
};
