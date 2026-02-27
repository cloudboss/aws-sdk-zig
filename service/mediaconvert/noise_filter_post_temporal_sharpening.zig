/// When you set Noise reducer to Temporal, the bandwidth and sharpness of your
/// output is reduced. You can optionally use Post temporal sharpening to apply
/// sharpening to the edges of your output. Note that Post temporal sharpening
/// will also make the bandwidth reduction from the Noise reducer smaller. The
/// default behavior, Auto, allows the transcoder to determine whether to apply
/// sharpening, depending on your input type and quality. When you set Post
/// temporal sharpening to Enabled, specify how much sharpening is applied using
/// Post temporal sharpening strength. Set Post temporal sharpening to Disabled
/// to not apply sharpening.
pub const NoiseFilterPostTemporalSharpening = enum {
    disabled,
    enabled,
    auto,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
        .auto = "AUTO",
    };
};
