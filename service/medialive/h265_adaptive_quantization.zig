/// H265 Adaptive Quantization
pub const H265AdaptiveQuantization = enum {
    auto,
    high,
    higher,
    low,
    max,
    medium,
    off,

    pub const json_field_names = .{
        .auto = "AUTO",
        .high = "HIGH",
        .higher = "HIGHER",
        .low = "LOW",
        .max = "MAX",
        .medium = "MEDIUM",
        .off = "OFF",
    };
};
