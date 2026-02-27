pub const FleetSortByType = enum {
    name,
    created_time,
    last_modified_time,

    pub const json_field_names = .{
        .name = "NAME",
        .created_time = "CREATED_TIME",
        .last_modified_time = "LAST_MODIFIED_TIME",
    };
};
