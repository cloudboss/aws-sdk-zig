pub const ScanState = enum {
    in_progress,
    successful,
    failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .successful = "SUCCESSFUL",
        .failed = "FAILED",
    };
};
