const DominantColor = @import("dominant_color.zig").DominantColor;
const DetectLabelsImageQuality = @import("detect_labels_image_quality.zig").DetectLabelsImageQuality;

/// The background of the image with regard to image quality and dominant
/// colors.
pub const DetectLabelsImageBackground = struct {
    /// The dominant colors found in the background of an image, defined with RGB
    /// values, CSS
    /// color name, simplified color name, and PixelPercentage (the percentage of
    /// image pixels that
    /// have a particular color).
    dominant_colors: ?[]const DominantColor,

    /// The quality of the image background as defined by brightness and sharpness.
    quality: ?DetectLabelsImageQuality,

    pub const json_field_names = .{
        .dominant_colors = "DominantColors",
        .quality = "Quality",
    };
};
