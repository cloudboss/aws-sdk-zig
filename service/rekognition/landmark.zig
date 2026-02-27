const LandmarkType = @import("landmark_type.zig").LandmarkType;

/// Indicates the location of the landmark on the face.
pub const Landmark = struct {
    /// Type of landmark.
    type: ?LandmarkType,

    /// The x-coordinate of the landmark expressed as a ratio of the width of the
    /// image. The
    /// x-coordinate is measured from the left-side of the image. For example, if
    /// the image is 700
    /// pixels wide and the x-coordinate of the landmark is at 350 pixels, this
    /// value is 0.5.
    x: ?f32,

    /// The y-coordinate of the landmark expressed as a ratio of the height of the
    /// image. The
    /// y-coordinate is measured from the top of the image. For example, if the
    /// image height is 200
    /// pixels and the y-coordinate of the landmark is at 50 pixels, this value is
    /// 0.25.
    y: ?f32,

    pub const json_field_names = .{
        .type = "Type",
        .x = "X",
        .y = "Y",
    };
};
