pub const TestSetDiscrepancyReportStatus = enum {
    in_progress,
    completed,
    failed,

    pub const json_field_names = .{
        .in_progress = "InProgress",
        .completed = "Completed",
        .failed = "Failed",
    };
};
