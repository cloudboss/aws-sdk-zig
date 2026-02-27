pub const DesiredState = enum {
    active,
    standby,
    deleted,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .standby = "STANDBY",
        .deleted = "DELETED",
    };
};
