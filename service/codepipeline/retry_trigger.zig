pub const RetryTrigger = enum {
    automated_stage_retry,
    manual_stage_retry,

    pub const json_field_names = .{
        .automated_stage_retry = "AutomatedStageRetry",
        .manual_stage_retry = "ManualStageRetry",
    };
};
