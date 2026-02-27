pub const Duration = enum {
    hr_24,
    day_7,
    day_14,
    day_30,

    pub const json_field_names = .{
        .hr_24 = "HR_24",
        .day_7 = "DAY_7",
        .day_14 = "DAY_14",
        .day_30 = "DAY_30",
    };
};
