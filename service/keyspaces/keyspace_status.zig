pub const KeyspaceStatus = enum {
    active,
    creating,
    updating,
    deleting,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
    };
};
