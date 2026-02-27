pub const ReferenceStatus = enum {
    active,
    deleting,
    deleted,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };
};
