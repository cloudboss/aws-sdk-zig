/// The details of a fixed budget schedule.
pub const FixedBudgetSchedule = struct {
    /// When the budget ends.
    end_time: i64,

    /// When the budget starts.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "endTime",
        .start_time = "startTime",
    };
};
