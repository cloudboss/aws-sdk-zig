pub const EvaluationFrequency = enum {
    one_min,
    five_min,
    ten_min,
    fifteen_min,
    thirty_min,
    one_hour,

    pub const json_field_names = .{
        .one_min = "ONE_MIN",
        .five_min = "FIVE_MIN",
        .ten_min = "TEN_MIN",
        .fifteen_min = "FIFTEEN_MIN",
        .thirty_min = "THIRTY_MIN",
        .one_hour = "ONE_HOUR",
    };
};
