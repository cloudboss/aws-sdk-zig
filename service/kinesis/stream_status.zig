pub const StreamStatus = enum {
    creating,
    deleting,
    active,
    updating,

    pub const json_field_names = .{
        .creating = "CREATING",
        .deleting = "DELETING",
        .active = "ACTIVE",
        .updating = "UPDATING",
    };
};
