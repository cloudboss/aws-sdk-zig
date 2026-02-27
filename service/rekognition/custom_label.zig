const Geometry = @import("geometry.zig").Geometry;

/// A custom label detected in an image by a call to DetectCustomLabels.
pub const CustomLabel = struct {
    /// The confidence that the model has in the detection of the custom label. The
    /// range is 0-100. A higher value indicates a higher confidence.
    confidence: ?f32,

    /// The location of the detected object on the image that corresponds to the
    /// custom label.
    /// Includes an axis aligned coarse bounding box surrounding the object and a
    /// finer grain polygon
    /// for more accurate spatial information.
    geometry: ?Geometry,

    /// The name of the custom label.
    name: ?[]const u8,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .geometry = "Geometry",
        .name = "Name",
    };
};
