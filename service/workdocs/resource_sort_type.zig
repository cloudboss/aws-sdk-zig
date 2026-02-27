pub const ResourceSortType = enum {
    date,
    name,

    pub const json_field_names = .{
        .date = "DATE",
        .name = "NAME",
    };
};
