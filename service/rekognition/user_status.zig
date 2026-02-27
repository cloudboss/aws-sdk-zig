pub const UserStatus = enum {
    active,
    updating,
    creating,
    created,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .updating = "UPDATING",
        .creating = "CREATING",
        .created = "CREATED",
    };
};
