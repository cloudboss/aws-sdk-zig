pub const PostLaunchActionExecutionStatus = enum {
    in_progress,
    success,
    failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .success = "SUCCESS",
        .failed = "FAILED",
    };
};
