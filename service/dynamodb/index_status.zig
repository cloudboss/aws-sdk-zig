pub const IndexStatus = enum {
    creating,
    updating,
    deleting,
    active,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .active = "ACTIVE",
    };
};
