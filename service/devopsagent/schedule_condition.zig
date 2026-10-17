const ScheduleSpec = @import("schedule_spec.zig").ScheduleSpec;

/// Expression-based schedule condition. CreateTrigger callers using this
/// condition supply expression and omit spec. Trigger responses always use this
/// condition, include the persisted or derived expression, and also include
/// spec when the trigger was created from a structured schedule.
pub const ScheduleCondition = struct {
    /// EventBridge cron or rate expression. Required for existing request and
    /// response compatibility. For a structured schedule response, this is the
    /// expression derived by Backlog.
    expression: ?[]const u8 = null,

    /// Structured schedule source of truth (cron | timeRange). On CreateTrigger
    /// supply exactly one of spec or expression. Present in responses together with
    /// the derived expression for structured triggers.
    spec: ?ScheduleSpec = null,

    pub const json_field_names = .{
        .expression = "expression",
        .spec = "spec",
    };
};
