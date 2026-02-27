pub const ImageSetState = enum {
    active,
    locked,
    deleted,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .locked = "LOCKED",
        .deleted = "DELETED",
    };
};
