pub const State = enum {
    active,
    deleted,

    pub const json_field_names = .{
        .active = "Active",
        .deleted = "Deleted",
    };
};
