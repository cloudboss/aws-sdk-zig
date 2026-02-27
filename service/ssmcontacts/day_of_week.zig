pub const DayOfWeek = enum {
    mon,
    tue,
    wed,
    thu,
    fri,
    sat,
    sun,

    pub const json_field_names = .{
        .mon = "MON",
        .tue = "TUE",
        .wed = "WED",
        .thu = "THU",
        .fri = "FRI",
        .sat = "SAT",
        .sun = "SUN",
    };
};
