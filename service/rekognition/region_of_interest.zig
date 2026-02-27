const BoundingBox = @import("bounding_box.zig").BoundingBox;
const Point = @import("point.zig").Point;

/// Specifies a location within the frame that Rekognition checks for objects of
/// interest such as text, labels, or faces. It uses a `BoundingBox`
/// or `Polygon` to set a region of the screen.
///
/// A word, face, or label is included in the region if it is more than half in
/// that region. If there is more than
/// one region, the word, face, or label is compared with all regions of the
/// screen. Any object of interest that is more than half in a region
/// is kept in the results.
pub const RegionOfInterest = struct {
    /// The box representing a region of interest on screen.
    bounding_box: ?BoundingBox,

    /// Specifies a shape made up of up to 10 `Point` objects to define a region of
    /// interest.
    polygon: ?[]const Point,

    pub const json_field_names = .{
        .bounding_box = "BoundingBox",
        .polygon = "Polygon",
    };
};
