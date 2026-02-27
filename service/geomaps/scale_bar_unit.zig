pub const ScaleBarUnit = enum {
    kilometers,
    kilometers_miles,
    miles,
    miles_kilometers,

    pub const json_field_names = .{
        .kilometers = "KILOMETERS",
        .kilometers_miles = "KILOMETERS_MILES",
        .miles = "MILES",
        .miles_kilometers = "MILES_KILOMETERS",
    };
};
