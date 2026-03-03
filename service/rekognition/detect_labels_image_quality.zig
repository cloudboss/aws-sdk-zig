/// The quality of an image provided for label detection, with regard to
/// brightness,
/// sharpness, and contrast.
pub const DetectLabelsImageQuality = struct {
    /// The brightness of an image provided for label detection.
    brightness: ?f32 = null,

    /// The contrast of an image provided for label detection.
    contrast: ?f32 = null,

    /// The sharpness of an image provided for label detection.
    sharpness: ?f32 = null,

    pub const json_field_names = .{
        .brightness = "Brightness",
        .contrast = "Contrast",
        .sharpness = "Sharpness",
    };
};
