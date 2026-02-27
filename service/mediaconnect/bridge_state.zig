pub const BridgeState = enum {
    creating,
    standby,
    starting,
    deploying,
    active,
    stopping,
    deleting,
    deleted,
    start_failed,
    start_pending,
    stop_failed,
    updating,

    pub const json_field_names = .{
        .creating = "CREATING",
        .standby = "STANDBY",
        .starting = "STARTING",
        .deploying = "DEPLOYING",
        .active = "ACTIVE",
        .stopping = "STOPPING",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .start_failed = "START_FAILED",
        .start_pending = "START_PENDING",
        .stop_failed = "STOP_FAILED",
        .updating = "UPDATING",
    };
};
