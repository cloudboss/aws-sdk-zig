const SheetImageScalingType = @import("sheet_image_scaling_type.zig").SheetImageScalingType;

/// Determines how the image is scaled
pub const SheetImageScalingConfiguration = struct {
    /// The scaling option to use when fitting the image inside the container.
    ///
    /// Valid values are defined as follows:
    ///
    /// * `SCALE_TO_WIDTH`: The image takes up the entire width of the container.
    ///   The image aspect ratio is preserved.
    ///
    /// * `SCALE_TO_HEIGHT`: The image takes up the entire height of the container.
    ///   The image aspect ratio is preserved.
    ///
    /// * `SCALE_TO_CONTAINER`: The image takes up the entire width and height of
    ///   the container. The image aspect ratio is not preserved.
    ///
    /// * `SCALE_NONE`: The image is displayed in its original size and is not
    ///   scaled to the container.
    scaling_type: ?SheetImageScalingType = null,

    pub const json_field_names = .{
        .scaling_type = "ScalingType",
    };
};
