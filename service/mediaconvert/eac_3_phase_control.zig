/// Controls the amount of phase-shift applied to the surround channels. Only
/// used for 3/2 coding mode.
pub const Eac3PhaseControl = enum {
    shift_90_degrees,
    no_shift,

    pub const json_field_names = .{
        .shift_90_degrees = "SHIFT_90_DEGREES",
        .no_shift = "NO_SHIFT",
    };
};
