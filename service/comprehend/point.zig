/// The X and Y coordinates of a point on a document page.
///
/// For additional information, see
/// [Point](https://docs.aws.amazon.com/textract/latest/dg/API_Point.html) in
/// the Amazon Textract API reference.
pub const Point = struct {
    /// The value of the X coordinate for a point on a polygon
    x: ?f32 = null,

    /// The value of the Y coordinate for a point on a polygon
    y: ?f32 = null,

    pub const json_field_names = .{
        .x = "X",
        .y = "Y",
    };
};
