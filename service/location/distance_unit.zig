pub const DistanceUnit = enum {
    kilometers,
    miles,

    pub const json_field_names = .{
        .kilometers = "Kilometers",
        .miles = "Miles",
    };
};
