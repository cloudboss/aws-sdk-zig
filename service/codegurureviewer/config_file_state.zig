pub const ConfigFileState = enum {
    present,
    absent,
    present_with_errors,

    pub const json_field_names = .{
        .present = "PRESENT",
        .absent = "ABSENT",
        .present_with_errors = "PRESENT_WITH_ERRORS",
    };
};
