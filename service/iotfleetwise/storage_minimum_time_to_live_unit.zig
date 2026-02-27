pub const StorageMinimumTimeToLiveUnit = enum {
    hours,
    days,
    weeks,

    pub const json_field_names = .{
        .hours = "HOURS",
        .days = "DAYS",
        .weeks = "WEEKS",
    };
};
