pub const StateEnum = enum {
    created,
    deleting,
    active,

    pub const json_field_names = .{
        .created = "CREATED",
        .deleting = "DELETING",
        .active = "ACTIVE",
    };
};
