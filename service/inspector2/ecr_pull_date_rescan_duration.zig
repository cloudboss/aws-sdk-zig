pub const EcrPullDateRescanDuration = enum {
    days_14,
    days_30,
    days_60,
    days_90,
    days_180,

    pub const json_field_names = .{
        .days_14 = "DAYS_14",
        .days_30 = "DAYS_30",
        .days_60 = "DAYS_60",
        .days_90 = "DAYS_90",
        .days_180 = "DAYS_180",
    };
};
