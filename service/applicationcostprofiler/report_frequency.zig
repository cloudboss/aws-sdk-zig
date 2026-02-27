pub const ReportFrequency = enum {
    monthly,
    daily,
    all,

    pub const json_field_names = .{
        .monthly = "MONTHLY",
        .daily = "DAILY",
        .all = "ALL",
    };
};
