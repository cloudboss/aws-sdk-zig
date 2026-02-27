pub const SpeakerEnrollmentJobStatus = enum {
    submitted,
    in_progress,
    completed,
    completed_with_errors,
    failed,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .completed_with_errors = "COMPLETED_WITH_ERRORS",
        .failed = "FAILED",
    };
};
