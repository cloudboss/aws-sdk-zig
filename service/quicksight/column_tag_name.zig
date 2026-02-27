pub const ColumnTagName = enum {
    column_geographic_role,
    column_description,

    pub const json_field_names = .{
        .column_geographic_role = "COLUMN_GEOGRAPHIC_ROLE",
        .column_description = "COLUMN_DESCRIPTION",
    };
};
