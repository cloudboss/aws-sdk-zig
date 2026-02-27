pub const VirtualNodeStatusCode = enum {
    active,
    inactive,
    deleted,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .deleted = "DELETED",
    };
};
