pub const Period = enum {
    one_minute,
    five_minute,
    one_hour,
    iteration_number,

    pub const json_field_names = .{
        .one_minute = "ONE_MINUTE",
        .five_minute = "FIVE_MINUTE",
        .one_hour = "ONE_HOUR",
        .iteration_number = "ITERATION_NUMBER",
    };
};
