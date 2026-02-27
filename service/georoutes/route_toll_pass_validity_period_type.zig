pub const RouteTollPassValidityPeriodType = enum {
    annual,
    days,
    extended_annual,
    minutes,
    months,

    pub const json_field_names = .{
        .annual = "ANNUAL",
        .days = "DAYS",
        .extended_annual = "EXTENDED_ANNUAL",
        .minutes = "MINUTES",
        .months = "MONTHS",
    };
};
