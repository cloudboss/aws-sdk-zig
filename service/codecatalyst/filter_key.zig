pub const FilterKey = enum {
    has_access_to,
    name,

    pub const json_field_names = .{
        .has_access_to = "HAS_ACCESS_TO",
        .name = "NAME",
    };
};
