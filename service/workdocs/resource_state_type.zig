pub const ResourceStateType = enum {
    active,
    restoring,
    recycling,
    recycled,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .restoring = "RESTORING",
        .recycling = "RECYCLING",
        .recycled = "RECYCLED",
    };
};
