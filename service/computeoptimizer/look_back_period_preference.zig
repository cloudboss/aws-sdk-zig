pub const LookBackPeriodPreference = enum {
    days_14,
    days_32,
    days_93,

    pub const json_field_names = .{
        .days_14 = "DAYS_14",
        .days_32 = "DAYS_32",
        .days_93 = "DAYS_93",
    };
};
