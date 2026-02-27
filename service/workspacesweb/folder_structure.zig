pub const FolderStructure = enum {
    flat,
    nested_by_date,

    pub const json_field_names = .{
        .flat = "FLAT",
        .nested_by_date = "NESTED_BY_DATE",
    };
};
