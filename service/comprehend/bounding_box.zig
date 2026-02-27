/// The bounding box around the detected page
/// or around an element on a document page.
/// The left (x-coordinate) and top (y-coordinate) are coordinates that
/// represent the top and left sides of the bounding box. Note that the
/// upper-left
/// corner of the image is the origin (0,0).
///
/// For additional information, see
/// [BoundingBox](https://docs.aws.amazon.com/textract/latest/dg/API_BoundingBox.html) in the Amazon Textract API reference.
pub const BoundingBox = struct {
    /// The height of the bounding box as a ratio of the overall document page
    /// height.
    height: ?f32,

    /// The left coordinate of the bounding box as a ratio of overall document page
    /// width.
    left: ?f32,

    /// The top coordinate of the bounding box as a ratio of overall document page
    /// height.
    top: ?f32,

    /// The width of the bounding box as a ratio of the overall document page width.
    width: ?f32,

    pub const json_field_names = .{
        .height = "Height",
        .left = "Left",
        .top = "Top",
        .width = "Width",
    };
};
