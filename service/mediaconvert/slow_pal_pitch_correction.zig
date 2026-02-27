/// Use Slow PAL pitch correction to compensate for audio pitch changes during
/// slow PAL frame rate conversion. This setting only applies when Slow PAL is
/// enabled in your output video codec settings. To automatically apply audio
/// pitch correction: Choose Enabled. MediaConvert automatically applies a pitch
/// correction to your output to match the original content's audio pitch. To
/// not apply audio pitch correction: Keep the default value, Disabled.
pub const SlowPalPitchCorrection = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
