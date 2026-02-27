/// The recurrence rule for the SLO time window exclusion .
pub const RecurrenceRule = struct {
    /// A cron or rate expression that specifies the schedule for the exclusion
    /// window.
    expression: []const u8,

    pub const json_field_names = .{
        .expression = "Expression",
    };
};
