/// An inclusive time period that Amazon Macie usage data applies to. Possible
/// values are:
pub const TimeRange = enum {
    month_to_date,
    past_30_days,

    pub const json_field_names = .{
        .month_to_date = "MONTH_TO_DATE",
        .past_30_days = "PAST_30_DAYS",
    };
};
