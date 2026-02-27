/// Optionally specify the amount of sharpening to apply when you use the
/// Advanced input filter. Sharpening adds contrast to the edges of your video
/// content and can reduce softness. To apply no sharpening: Keep the default
/// value, Off. To apply a minimal amount of sharpening choose Low, or for the
/// maximum choose High.
pub const AdvancedInputFilterSharpen = enum {
    off,
    low,
    high,

    pub const json_field_names = .{
        .off = "OFF",
        .low = "LOW",
        .high = "HIGH",
    };
};
