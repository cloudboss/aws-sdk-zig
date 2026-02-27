const BoundingBox = @import("bounding_box.zig").BoundingBox;
const DominantColor = @import("dominant_color.zig").DominantColor;

/// An instance of a label returned by Amazon Rekognition Image (DetectLabels)
/// or by
/// Amazon Rekognition Video (GetLabelDetection).
pub const Instance = struct {
    /// The position of the label instance on the image.
    bounding_box: ?BoundingBox,

    /// The confidence that Amazon Rekognition has in the accuracy of the bounding
    /// box.
    confidence: ?f32,

    /// The dominant colors found in an individual instance of a label.
    dominant_colors: ?[]const DominantColor,

    pub const json_field_names = .{
        .bounding_box = "BoundingBox",
        .confidence = "Confidence",
        .dominant_colors = "DominantColors",
    };
};
