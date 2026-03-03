const RuleExecutionType = @import("rule_execution_type.zig").RuleExecutionType;

/// Contains information about a scheduled backup plan execution, including the
/// execution time, rule type, and associated rule identifier.
pub const ScheduledPlanExecutionMember = struct {
    /// The timestamp when the backup is scheduled to run, in Unix format and
    /// Coordinated Universal Time (UTC). The value is accurate to milliseconds.
    execution_time: ?i64 = null,

    /// The type of backup rule execution. Valid values are `CONTINUOUS`
    /// (point-in-time recovery), `SNAPSHOTS` (snapshot backups), or
    /// `CONTINUOUS_AND_SNAPSHOTS` (both types combined).
    rule_execution_type: ?RuleExecutionType = null,

    /// The unique identifier of the backup rule that will execute at the scheduled
    /// time.
    rule_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .execution_time = "ExecutionTime",
        .rule_execution_type = "RuleExecutionType",
        .rule_id = "RuleId",
    };
};
