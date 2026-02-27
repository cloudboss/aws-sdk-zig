pub const CoreNetworkState = enum {
    creating,
    updating,
    available,
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .available = "AVAILABLE",
        .deleting = "DELETING",
    };
};
