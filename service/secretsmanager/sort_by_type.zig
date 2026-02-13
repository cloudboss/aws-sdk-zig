pub const SortByType = enum {
    created_date,
    last_accessed_date,
    last_changed_date,
    name,

    pub const json_field_names = .{
        .created_date = "created_date",
        .last_accessed_date = "last_accessed_date",
        .last_changed_date = "last_changed_date",
        .name = "name",
    };
};
