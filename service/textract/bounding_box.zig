/// The bounding box around the detected page, text, key-value pair, table,
/// table cell, or
/// selection element on a document page. The `left` (x-coordinate) and
/// `top` (y-coordinate) are coordinates that represent the top and left sides
/// of
/// the bounding box. Note that the upper-left corner of the image is the origin
/// (0,0).
///
/// The `top` and `left` values returned are ratios of the overall
/// document page size. For example, if the input image is 700 x 200 pixels, and
/// the top-left
/// coordinate of the bounding box is 350 x 50 pixels, the API returns a `left`
/// value of 0.5 (350/700) and a `top` value of 0.25 (50/200).
///
/// The `width` and `height` values represent the dimensions of the
/// bounding box as a ratio of the overall document page dimension. For example,
/// if the
/// document page size is 700 x 200 pixels, and the bounding box width is 70
/// pixels, the width
/// returned is 0.1.
pub const BoundingBox = struct {
    /// The height of the bounding box as a ratio of the overall document page
    /// height.
    height: f32 = 0,

    /// The left coordinate of the bounding box as a ratio of overall document page
    /// width.
    left: f32 = 0,

    /// The top coordinate of the bounding box as a ratio of overall document page
    /// height.
    top: f32 = 0,

    /// The width of the bounding box as a ratio of the overall document page
    /// width.
    width: f32 = 0,

    pub const json_field_names = .{
        .height = "Height",
        .left = "Left",
        .top = "Top",
        .width = "Width",
    };
};
