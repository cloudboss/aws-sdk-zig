/// Use these settings when you set DolbyVisionLevel6Mode to SPECIFY to override
/// the MaxCLL and MaxFALL values in your input with new values.
pub const DolbyVisionLevel6Metadata = struct {
    /// Maximum Content Light Level. Static HDR metadata that corresponds to the
    /// brightest pixel in the entire stream. Measured in nits.
    max_cll: ?i32 = null,

    /// Maximum Frame-Average Light Level. Static HDR metadata that corresponds to
    /// the highest frame-average brightness in the entire stream. Measured in nits.
    max_fall: ?i32 = null,

    pub const json_field_names = .{
        .max_cll = "MaxCll",
        .max_fall = "MaxFall",
    };
};
