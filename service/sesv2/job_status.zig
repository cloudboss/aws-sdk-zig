/// The status of a job.
///
/// * `CREATED` – Job has just been created.
///
/// * `PROCESSING` – Job is processing.
///
/// * `ERROR` – An error occurred during processing.
///
/// * `COMPLETED` – Job has completed processing successfully.
pub const JobStatus = enum {
    created,
    processing,
    completed,
    failed,
    cancelled,

    pub const json_field_names = .{
        .created = "CREATED",
        .processing = "PROCESSING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .cancelled = "CANCELLED",
    };
};
