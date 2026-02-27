pub const AggregationPeriod = enum {
    one_day,
    seven_days,
    fourteen_days,

    pub const json_field_names = .{
        .one_day = "ONE_DAY",
        .seven_days = "SEVEN_DAYS",
        .fourteen_days = "FOURTEEN_DAYS",
    };
};
