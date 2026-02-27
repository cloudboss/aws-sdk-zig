/// Read-only; shows the last 50 values and change dates for the `NextSteps`
/// field.
pub const NextStepsHistory = struct {
    /// Indicates the step execution time.
    time: i64,

    /// Indicates the step's execution details.
    value: []const u8,

    pub const json_field_names = .{
        .time = "Time",
        .value = "Value",
    };
};
