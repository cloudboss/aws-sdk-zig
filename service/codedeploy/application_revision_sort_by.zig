pub const ApplicationRevisionSortBy = enum {
    register_time,
    first_used_time,
    last_used_time,

    pub const json_field_names = .{
        .register_time = "RegisterTime",
        .first_used_time = "FirstUsedTime",
        .last_used_time = "LastUsedTime",
    };
};
