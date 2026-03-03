/// The X and Y coordinates of a point on an image or video frame. The X and Y
/// values are
/// ratios of the overall image size or video resolution. For example, if an
/// input image is
/// 700x200 and the values are X=0.5 and Y=0.25, then the point is at the
/// (350,50) pixel
/// coordinate on the image.
///
/// An array of `Point` objects makes up a `Polygon`. A
/// `Polygon` is returned by DetectText and by DetectCustomLabels
/// `Polygon` represents a fine-grained polygon around a detected item. For more
/// information, see Geometry in the Amazon Rekognition Developer Guide.
pub const Point = struct {
    /// The value of the X coordinate for a point on a `Polygon`.
    x: ?f32 = null,

    /// The value of the Y coordinate for a point on a `Polygon`.
    y: ?f32 = null,

    pub const json_field_names = .{
        .x = "X",
        .y = "Y",
    };
};
