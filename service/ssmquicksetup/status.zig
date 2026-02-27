pub const Status = enum {
    initializing,
    deploying,
    succeeded,
    deleting,
    stopping,
    failed,
    stopped,
    delete_failed,
    stop_failed,
    none,

    pub const json_field_names = .{
        .initializing = "INITIALIZING",
        .deploying = "DEPLOYING",
        .succeeded = "SUCCEEDED",
        .deleting = "DELETING",
        .stopping = "STOPPING",
        .failed = "FAILED",
        .stopped = "STOPPED",
        .delete_failed = "DELETE_FAILED",
        .stop_failed = "STOP_FAILED",
        .none = "NONE",
    };
};
