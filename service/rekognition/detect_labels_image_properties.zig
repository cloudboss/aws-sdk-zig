const DetectLabelsImageBackground = @import("detect_labels_image_background.zig").DetectLabelsImageBackground;
const DominantColor = @import("dominant_color.zig").DominantColor;
const DetectLabelsImageForeground = @import("detect_labels_image_foreground.zig").DetectLabelsImageForeground;
const DetectLabelsImageQuality = @import("detect_labels_image_quality.zig").DetectLabelsImageQuality;

/// Information about the quality and dominant colors of an input image. Quality
/// and color
/// information is returned for the entire image, foreground, and background.
pub const DetectLabelsImageProperties = struct {
    /// Information about the properties of an image’s background, including the
    /// background’s
    /// quality and dominant colors, including the quality and dominant colors of
    /// the image.
    background: ?DetectLabelsImageBackground,

    /// Information about the dominant colors found in an image, described with RGB
    /// values, CSS
    /// color name, simplified color name, and PixelPercentage (the percentage of
    /// image pixels that
    /// have a particular color).
    dominant_colors: ?[]const DominantColor,

    /// Information about the properties of an image’s foreground, including the
    /// foreground’s
    /// quality and dominant colors, including the quality and dominant colors of
    /// the image.
    foreground: ?DetectLabelsImageForeground,

    /// Information about the quality of the image foreground as defined by
    /// brightness, sharpness,
    /// and contrast. The higher the value the greater the brightness, sharpness,
    /// and contrast
    /// respectively.
    quality: ?DetectLabelsImageQuality,

    pub const json_field_names = .{
        .background = "Background",
        .dominant_colors = "DominantColors",
        .foreground = "Foreground",
        .quality = "Quality",
    };
};
