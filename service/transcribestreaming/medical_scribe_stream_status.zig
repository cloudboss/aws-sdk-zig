pub const MedicalScribeStreamStatus = enum {
    in_progress,
    paused,
    failed,
    completed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .paused = "PAUSED",
        .failed = "FAILED",
        .completed = "COMPLETED",
    };
};
