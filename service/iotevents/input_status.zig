pub const InputStatus = enum {
    creating,
    updating,
    active,
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
    };
};
