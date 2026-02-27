/// Eac3 Phase Control
pub const Eac3PhaseControl = enum {
    no_shift,
    shift_90_degrees,

    pub const json_field_names = .{
        .no_shift = "NO_SHIFT",
        .shift_90_degrees = "SHIFT_90_DEGREES",
    };
};
