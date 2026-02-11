pub const GlobalTableStatus = enum {
    creating,
    active,
    deleting,
    updating,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .updating = "UPDATING",
    };
};
