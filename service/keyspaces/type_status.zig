pub const TypeStatus = enum {
    active,
    creating,
    deleting,
    restoring,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .creating = "CREATING",
        .deleting = "DELETING",
        .restoring = "RESTORING",
    };
};
