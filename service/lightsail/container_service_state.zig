pub const ContainerServiceState = enum {
    pending,
    ready,
    running,
    updating,
    deleting,
    disabled,
    deploying,

    pub const json_field_names = .{
        .pending = "PENDING",
        .ready = "READY",
        .running = "RUNNING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .disabled = "DISABLED",
        .deploying = "DEPLOYING",
    };
};
