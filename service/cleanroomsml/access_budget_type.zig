pub const AccessBudgetType = enum {
    calendar_day,
    calendar_month,
    calendar_week,
    lifetime,

    pub const json_field_names = .{
        .calendar_day = "CALENDAR_DAY",
        .calendar_month = "CALENDAR_MONTH",
        .calendar_week = "CALENDAR_WEEK",
        .lifetime = "LIFETIME",
    };
};
