pub const EcrRescanDuration = enum {
    lifetime,
    days_30,
    days_180,
    days_14,
    days_60,
    days_90,

    pub const json_field_names = .{
        .lifetime = "LIFETIME",
        .days_30 = "DAYS_30",
        .days_180 = "DAYS_180",
        .days_14 = "DAYS_14",
        .days_60 = "DAYS_60",
        .days_90 = "DAYS_90",
    };
};
