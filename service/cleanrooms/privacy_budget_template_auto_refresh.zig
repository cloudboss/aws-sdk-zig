pub const PrivacyBudgetTemplateAutoRefresh = enum {
    calendar_month,
    none,

    pub const json_field_names = .{
        .calendar_month = "CALENDAR_MONTH",
        .none = "NONE",
    };
};
