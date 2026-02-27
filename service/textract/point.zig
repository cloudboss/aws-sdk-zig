/// The X and Y coordinates of a point on a document page. The X and Y
/// values that are returned are ratios of the overall document page size. For
/// example, if the
/// input document is 700 x 200 and the operation returns X=0.5 and Y=0.25, then
/// the point is
/// at the (350,50) pixel coordinate on the document page.
///
/// An array of `Point` objects, `Polygon`, is returned
/// by DetectDocumentText. `Polygon` represents a fine-grained
/// polygon around detected text. For more information, see Geometry in the
/// Amazon Textract
/// Developer Guide.
pub const Point = struct {
    /// The value of the X coordinate for a point on a `Polygon`.
    x: f32 = 0,

    /// The value of the Y coordinate for a point on a `Polygon`.
    y: f32 = 0,

    pub const json_field_names = .{
        .x = "X",
        .y = "Y",
    };
};
