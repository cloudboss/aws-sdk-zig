pub const JobStatus = enum {
    created,
    pending,
    provisioning,
    running,
    failed,
    succeed,
    cancelling,
    cancelled,

    pub const json_field_names = .{
        .created = "CREATED",
        .pending = "PENDING",
        .provisioning = "PROVISIONING",
        .running = "RUNNING",
        .failed = "FAILED",
        .succeed = "SUCCEED",
        .cancelling = "CANCELLING",
        .cancelled = "CANCELLED",
    };
};
