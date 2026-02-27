/// Use Post temporal sharpening strength to define the amount of sharpening the
/// transcoder applies to your output. Set Post temporal sharpening strength to
/// Low, Medium, or High to indicate the amount of sharpening.
pub const NoiseFilterPostTemporalSharpeningStrength = enum {
    low,
    medium,
    high,

    pub const json_field_names = .{
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
    };
};
