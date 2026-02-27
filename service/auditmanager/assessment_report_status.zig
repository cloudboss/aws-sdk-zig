pub const AssessmentReportStatus = enum {
    complete,
    in_progress,
    failed,

    pub const json_field_names = .{
        .complete = "COMPLETE",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
    };
};
