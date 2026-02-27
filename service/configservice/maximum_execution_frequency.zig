pub const MaximumExecutionFrequency = enum {
    one_hour,
    three_hours,
    six_hours,
    twelve_hours,
    twenty_four_hours,

    pub const json_field_names = .{
        .one_hour = "One_Hour",
        .three_hours = "Three_Hours",
        .six_hours = "Six_Hours",
        .twelve_hours = "Twelve_Hours",
        .twenty_four_hours = "TwentyFour_Hours",
    };
};
