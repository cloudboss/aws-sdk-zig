pub const EvaluationType = enum {
    standard,
    calibration,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .calibration = "CALIBRATION",
    };
};
