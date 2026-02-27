const BoundingBox = @import("bounding_box.zig").BoundingBox;
const Point = @import("point.zig").Point;

/// Information about where the following items are located on a document page:
/// detected
/// page, text, key-value pairs, tables, table cells, and selection elements.
pub const Geometry = struct {
    /// An axis-aligned coarse representation of the location of the recognized item
    /// on the
    /// document page.
    bounding_box: ?BoundingBox,

    /// Within the bounding box, a fine-grained polygon around the recognized item.
    polygon: ?[]const Point,

    /// Provides a numerical value corresponding to the rotation of the text.
    rotation_angle: ?f32,

    pub const json_field_names = .{
        .bounding_box = "BoundingBox",
        .polygon = "Polygon",
        .rotation_angle = "RotationAngle",
    };
};
