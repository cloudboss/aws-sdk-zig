/// Film grain synthesis replaces film grain present in your content with
/// similar quality synthesized AV1 film grain. We recommend that you choose
/// Enabled to reduce the bandwidth of your QVBR quality level 5, 6, 7, or 8
/// outputs. For QVBR quality level 9 or 10 outputs we recommend that you keep
/// the default value, Disabled. When you include Film grain synthesis, you
/// cannot include the Noise reducer preprocessor.
pub const Av1FilmGrainSynthesis = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
