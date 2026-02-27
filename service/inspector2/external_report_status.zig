pub const ExternalReportStatus = enum {
    succeeded,
    in_progress,
    cancelled,
    failed,

    pub const json_field_names = .{
        .succeeded = "SUCCEEDED",
        .in_progress = "IN_PROGRESS",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
    };
};
