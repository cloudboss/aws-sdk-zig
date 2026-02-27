pub const LastUpdateStatusValue = enum {
    successful,
    failed,
    in_progress,

    pub const json_field_names = .{
        .successful = "SUCCESSFUL",
        .failed = "FAILED",
        .in_progress = "IN_PROGRESS",
    };
};
