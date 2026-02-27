pub const TriggerState = enum {
    creating,
    created,
    activating,
    activated,
    deactivating,
    deactivated,
    deleting,
    updating,

    pub const json_field_names = .{
        .creating = "CREATING",
        .created = "CREATED",
        .activating = "ACTIVATING",
        .activated = "ACTIVATED",
        .deactivating = "DEACTIVATING",
        .deactivated = "DEACTIVATED",
        .deleting = "DELETING",
        .updating = "UPDATING",
    };
};
