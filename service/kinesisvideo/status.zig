pub const Status = enum {
    creating,
    active,
    updating,
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .deleting = "DELETING",
    };
};
