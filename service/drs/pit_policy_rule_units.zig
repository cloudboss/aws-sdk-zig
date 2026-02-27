pub const PITPolicyRuleUnits = enum {
    minute,
    hour,
    day,

    pub const json_field_names = .{
        .minute = "MINUTE",
        .hour = "HOUR",
        .day = "DAY",
    };
};
