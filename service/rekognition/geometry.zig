const BoundingBox = @import("bounding_box.zig").BoundingBox;
const Point = @import("point.zig").Point;

/// Information about where an object (DetectCustomLabels) or text (DetectText)
/// is located on an image.
pub const Geometry = struct {
    /// An axis-aligned coarse representation of the detected item's location on the
    /// image.
    bounding_box: ?BoundingBox = null,

    /// Within the bounding box, a fine-grained polygon around the detected item.
    polygon: ?[]const Point = null,

    pub const json_field_names = .{
        .bounding_box = "BoundingBox",
        .polygon = "Polygon",
    };
};
