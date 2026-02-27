pub const MetadataGenerationRunStatus = enum {
    submitted,
    in_progress,
    canceled,
    succeeded,
    failed,
    partially_succeeded,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .in_progress = "IN_PROGRESS",
        .canceled = "CANCELED",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .partially_succeeded = "PARTIALLY_SUCCEEDED",
    };
};
