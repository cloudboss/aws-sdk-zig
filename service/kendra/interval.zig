pub const Interval = enum {
    this_month,
    this_week,
    one_week_ago,
    two_weeks_ago,
    one_month_ago,
    two_months_ago,

    pub const json_field_names = .{
        .this_month = "THIS_MONTH",
        .this_week = "THIS_WEEK",
        .one_week_ago = "ONE_WEEK_AGO",
        .two_weeks_ago = "TWO_WEEKS_AGO",
        .one_month_ago = "ONE_MONTH_AGO",
        .two_months_ago = "TWO_MONTHS_AGO",
    };
};
