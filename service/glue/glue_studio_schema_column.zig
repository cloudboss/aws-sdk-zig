/// Specifies a single column in a Glue schema definition.
pub const GlueStudioSchemaColumn = struct {
    /// The data type of the column as defined in Glue Studio.
    glue_studio_type: ?[]const u8,

    /// The name of the column in the Glue Studio schema.
    name: []const u8,

    /// The hive type for this column in the Glue Studio schema.
    type: ?[]const u8,

    pub const json_field_names = .{
        .glue_studio_type = "GlueStudioType",
        .name = "Name",
        .type = "Type",
    };
};
