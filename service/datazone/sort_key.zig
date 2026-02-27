pub const SortKey = enum {
    created_at,
    updated_at,

    pub const json_field_names = .{
        .created_at = "CREATED_AT",
        .updated_at = "UPDATED_AT",
    };
};
