pub const PeriodicScanFrequency = enum {
    weekly,
    monthly,
    never,

    pub const json_field_names = .{
        .weekly = "WEEKLY",
        .monthly = "MONTHLY",
        .never = "NEVER",
    };
};
