pub const MissingDataTreatmentOption = enum {
    interpolate,
    show_as_zero,
    show_as_blank,

    pub const json_field_names = .{
        .interpolate = "INTERPOLATE",
        .show_as_zero = "SHOW_AS_ZERO",
        .show_as_blank = "SHOW_AS_BLANK",
    };
};
