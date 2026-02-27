/// Enables Alternate Transfer Function SEI message for outputs using Hybrid Log
/// Gamma (HLG) Electro-Optical Transfer Function (EOTF).
pub const H265AlternateTransferFunctionSei = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
