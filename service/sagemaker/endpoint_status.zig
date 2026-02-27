pub const EndpointStatus = enum {
    out_of_service,
    creating,
    updating,
    system_updating,
    rolling_back,
    in_service,
    deleting,
    failed,
    update_rollback_failed,

    pub const json_field_names = .{
        .out_of_service = "OUT_OF_SERVICE",
        .creating = "CREATING",
        .updating = "UPDATING",
        .system_updating = "SYSTEM_UPDATING",
        .rolling_back = "ROLLING_BACK",
        .in_service = "IN_SERVICE",
        .deleting = "DELETING",
        .failed = "FAILED",
        .update_rollback_failed = "UPDATE_ROLLBACK_FAILED",
    };
};
