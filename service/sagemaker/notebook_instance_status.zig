pub const NotebookInstanceStatus = enum {
    pending,
    in_service,
    stopping,
    stopped,
    failed,
    deleting,
    updating,

    pub const json_field_names = .{
        .pending = "Pending",
        .in_service = "InService",
        .stopping = "Stopping",
        .stopped = "Stopped",
        .failed = "Failed",
        .deleting = "Deleting",
        .updating = "Updating",
    };
};
