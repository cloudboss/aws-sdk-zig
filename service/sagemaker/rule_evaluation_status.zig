pub const RuleEvaluationStatus = enum {
    in_progress,
    no_issues_found,
    issues_found,
    @"error",
    stopping,
    stopped,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .no_issues_found = "NO_ISSUES_FOUND",
        .issues_found = "ISSUES_FOUND",
        .@"error" = "ERROR",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
    };
};
