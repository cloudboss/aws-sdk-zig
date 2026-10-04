/// A time period for Enterprise Support billing.
pub const EnterpriseSupportTimePeriod = struct {
    /// The begin date of the time period.
    begin_date: i64,

    /// The end date of the time period.
    end_date: ?i64 = null,

    pub const json_field_names = .{
        .begin_date = "beginDate",
        .end_date = "endDate",
    };
};
