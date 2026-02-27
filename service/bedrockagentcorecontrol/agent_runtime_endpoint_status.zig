pub const AgentRuntimeEndpointStatus = enum {
    creating,
    create_failed,
    updating,
    update_failed,
    ready,
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .updating = "UPDATING",
        .update_failed = "UPDATE_FAILED",
        .ready = "READY",
        .deleting = "DELETING",
    };
};
