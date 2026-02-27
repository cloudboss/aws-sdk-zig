/// Aac Vbr Quality
pub const AacVbrQuality = enum {
    high,
    low,
    medium_high,
    medium_low,

    pub const json_field_names = .{
        .high = "HIGH",
        .low = "LOW",
        .medium_high = "MEDIUM_HIGH",
        .medium_low = "MEDIUM_LOW",
    };
};
