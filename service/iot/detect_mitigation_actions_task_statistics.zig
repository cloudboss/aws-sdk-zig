/// The statistics of a mitigation action task.
pub const DetectMitigationActionsTaskStatistics = struct {
    /// The actions that were performed.
    actions_executed: ?i64,

    /// The actions that failed.
    actions_failed: ?i64,

    /// The actions that were skipped.
    actions_skipped: ?i64,

    pub const json_field_names = .{
        .actions_executed = "actionsExecuted",
        .actions_failed = "actionsFailed",
        .actions_skipped = "actionsSkipped",
    };
};
