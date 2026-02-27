pub const DashboardStatus = enum {
    creating,
    created,
    updating,
    updated,
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .created = "CREATED",
        .updating = "UPDATING",
        .updated = "UPDATED",
        .deleting = "DELETING",
    };
};
