pub const AssessmentStatus = enum {
    in_progress,
    complete,
    failed,
    stopped,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .complete = "COMPLETE",
        .failed = "FAILED",
        .stopped = "STOPPED",
    };
};
