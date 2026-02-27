const BoundingBox = @import("bounding_box.zig").BoundingBox;
const Point = @import("point.zig").Point;

/// Information about the location of items on a document page.
///
/// For additional information, see
/// [Geometry](https://docs.aws.amazon.com/textract/latest/dg/API_Geometry.html)
/// in the Amazon Textract API reference.
pub const Geometry = struct {
    /// An axis-aligned coarse representation of the location of the recognized item
    /// on the
    /// document page.
    bounding_box: ?BoundingBox,

    /// Within the bounding box, a fine-grained polygon around the recognized item.
    polygon: ?[]const Point,

    pub const json_field_names = .{
        .bounding_box = "BoundingBox",
        .polygon = "Polygon",
    };
};
