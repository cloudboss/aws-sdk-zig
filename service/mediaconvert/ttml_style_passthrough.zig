/// Pass through style and position information from a TTML-like input source
/// (TTML, IMSC, SMPTE-TT) to the TTML output.
pub const TtmlStylePassthrough = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
