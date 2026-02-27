/// Status of the dataset process returned from scheduler service.
pub const DatasetStatus = enum {
    pending,
    failed,
    success,
    running,

    pub const json_field_names = .{
        .pending = "PENDING",
        .failed = "FAILED",
        .success = "SUCCESS",
        .running = "RUNNING",
    };
};
