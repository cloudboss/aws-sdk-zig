pub const CRResourceStatus = enum {
    creating,
    operational,
    updating,
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .operational = "OPERATIONAL",
        .updating = "UPDATING",
        .deleting = "DELETING",
    };
};
