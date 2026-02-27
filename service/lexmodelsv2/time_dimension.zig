pub const TimeDimension = enum {
    hours,
    days,
    weeks,

    pub const json_field_names = .{
        .hours = "Hours",
        .days = "Days",
        .weeks = "Weeks",
    };
};
