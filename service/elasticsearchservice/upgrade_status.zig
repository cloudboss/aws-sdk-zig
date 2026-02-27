pub const UpgradeStatus = enum {
    in_progress,
    succeeded,
    succeeded_with_issues,
    failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .succeeded = "SUCCEEDED",
        .succeeded_with_issues = "SUCCEEDED_WITH_ISSUES",
        .failed = "FAILED",
    };
};
