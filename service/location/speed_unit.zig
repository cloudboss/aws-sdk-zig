pub const SpeedUnit = enum {
    kilometers_per_hour,
    miles_per_hour,

    pub const json_field_names = .{
        .kilometers_per_hour = "KilometersPerHour",
        .miles_per_hour = "MilesPerHour",
    };
};
