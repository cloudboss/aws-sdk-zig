pub const ShippingOption = enum {
    second_day,
    next_day,
    express,
    standard,

    pub const json_field_names = .{
        .second_day = "SECOND_DAY",
        .next_day = "NEXT_DAY",
        .express = "EXPRESS",
        .standard = "STANDARD",
    };
};
