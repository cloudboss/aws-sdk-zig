const MultiViewInput = @import("multi_view_input.zig").MultiViewInput;

/// Specify the enhancement layer input video file path for Multi View outputs.
/// The base layer input is treated as the left eye and this Multi View input is
/// treated as the right eye. Only one Multi View input is currently supported.
/// MediaConvert encodes both views into a single MV-HEVC output codec. When you
/// add MultiViewSettings to your job, you can only produce Multi View outputs.
/// Adding any other codec output to the same job is not supported.
pub const MultiViewSettings = struct {
    /// Input settings for MultiView Settings. You can include exactly one input as
    /// enhancement layer.
    input: ?MultiViewInput = null,

    pub const json_field_names = .{
        .input = "Input",
    };
};
