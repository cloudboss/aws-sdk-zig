/// Identifies face image brightness and sharpness.
pub const ImageQuality = struct {
    /// Value representing brightness of the face. The service returns a value
    /// between 0 and
    /// 100 (inclusive). A higher value indicates a brighter face image.
    brightness: ?f32,

    /// Value representing sharpness of the face. The service returns a value
    /// between 0 and 100
    /// (inclusive). A higher value indicates a sharper face image.
    sharpness: ?f32,

    pub const json_field_names = .{
        .brightness = "Brightness",
        .sharpness = "Sharpness",
    };
};
