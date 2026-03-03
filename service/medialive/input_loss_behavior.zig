const InputLocation = @import("input_location.zig").InputLocation;
const InputLossImageType = @import("input_loss_image_type.zig").InputLossImageType;

/// Input Loss Behavior
pub const InputLossBehavior = struct {
    /// Documentation update needed
    black_frame_msec: ?i32 = null,

    /// When input loss image type is "color" this field specifies the color to use.
    /// Value: 6 hex characters representing the values of RGB.
    input_loss_image_color: ?[]const u8 = null,

    /// When input loss image type is "slate" these fields specify the parameters
    /// for accessing the slate.
    input_loss_image_slate: ?InputLocation = null,

    /// Indicates whether to substitute a solid color or a slate into the output
    /// after input loss exceeds blackFrameMsec.
    input_loss_image_type: ?InputLossImageType = null,

    /// Documentation update needed
    repeat_frame_msec: ?i32 = null,

    pub const json_field_names = .{
        .black_frame_msec = "BlackFrameMsec",
        .input_loss_image_color = "InputLossImageColor",
        .input_loss_image_slate = "InputLossImageSlate",
        .input_loss_image_type = "InputLossImageType",
        .repeat_frame_msec = "RepeatFrameMsec",
    };
};
