pub const AmazonopensearchserviceIndexRotationPeriod = enum {
    no_rotation,
    one_hour,
    one_day,
    one_week,
    one_month,

    pub const json_field_names = .{
        .no_rotation = "NoRotation",
        .one_hour = "OneHour",
        .one_day = "OneDay",
        .one_week = "OneWeek",
        .one_month = "OneMonth",
    };
};
