/// Cron or rate schedule. Trigger-created custom-agent schedules use an
/// EventBridge flexible window of up to 30 minutes for load distribution.
pub const CronSchedule = struct {
    /// EventBridge cron or rate expression that anchors the flexible window
    expression: []const u8,

    pub const json_field_names = .{
        .expression = "expression",
    };
};
