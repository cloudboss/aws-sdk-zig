/// Status of the ingestion process returned from scheduler service.
pub const IngestionStatus = enum {
    pending,
    failed,
    success,
    running,
    stop_requested,

    pub const json_field_names = .{
        .pending = "PENDING",
        .failed = "FAILED",
        .success = "SUCCESS",
        .running = "RUNNING",
        .stop_requested = "STOP_REQUESTED",
    };
};
