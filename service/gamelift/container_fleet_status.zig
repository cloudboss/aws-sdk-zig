pub const ContainerFleetStatus = enum {
    pending,
    creating,
    created,
    activating,
    active,
    updating,
    deleting,

    pub const json_field_names = .{
        .pending = "PENDING",
        .creating = "CREATING",
        .created = "CREATED",
        .activating = "ACTIVATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .deleting = "DELETING",
    };
};
