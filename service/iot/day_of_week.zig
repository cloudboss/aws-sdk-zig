pub const DayOfWeek = enum {
    sun,
    mon,
    tue,
    wed,
    thu,
    fri,
    sat,

    pub const json_field_names = .{
        .sun = "SUN",
        .mon = "MON",
        .tue = "TUE",
        .wed = "WED",
        .thu = "THU",
        .fri = "FRI",
        .sat = "SAT",
    };
};
