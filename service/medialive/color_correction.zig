const ColorSpace = @import("color_space.zig").ColorSpace;

/// Property of ColorCorrectionSettings. Used for custom color space conversion.
/// The object identifies one 3D LUT file and specifies the input/output color
/// space combination that the file will be used for.
pub const ColorCorrection = struct {
    /// The color space of the input.
    input_color_space: ColorSpace,

    /// The color space of the output.
    output_color_space: ColorSpace,

    /// The URI of the 3D LUT file. The protocol must be 's3:' or 's3ssl:':.
    uri: []const u8,

    pub const json_field_names = .{
        .input_color_space = "InputColorSpace",
        .output_color_space = "OutputColorSpace",
        .uri = "Uri",
    };
};
