/// Schedule-based condition that fires the Trigger
pub const ScheduleCondition = struct {
    /// The schedule expression
    expression: []const u8,

    pub const json_field_names = .{
        .expression = "expression",
    };
};
