pub const UpdateProgress = enum {
    pending,
    in_progress,
    verifying,
    rebooting,
    downloading,
    completed,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .verifying = "VERIFYING",
        .rebooting = "REBOOTING",
        .downloading = "DOWNLOADING",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };
};
