const ColorSpace = @import("color_space.zig").ColorSpace;

/// Custom 3D lut settings
pub const ColorConversion3DLUTSetting = struct {
    /// Specify the input file S3, HTTP, or HTTPS URL for your 3D LUT .cube file.
    /// Note that MediaConvert accepts 3D LUT files up to 8MB in size.
    file_input: ?[]const u8 = null,

    /// Specify which inputs use this 3D LUT, according to their color space.
    input_color_space: ?ColorSpace = null,

    /// Specify which inputs use this 3D LUT, according to their luminance. To apply
    /// this 3D LUT to HDR10 or P3D65 (HDR) inputs with a specific mastering
    /// luminance: Enter an integer from 0 to 2147483647, corresponding to the
    /// input's Maximum luminance value. To apply this 3D LUT to any input
    /// regardless of its luminance: Leave blank, or enter 0.
    input_mastering_luminance: ?i32 = null,

    /// Specify which outputs use this 3D LUT, according to their color space.
    output_color_space: ?ColorSpace = null,

    /// Specify which outputs use this 3D LUT, according to their luminance. To
    /// apply this 3D LUT to HDR10 or P3D65 (HDR) outputs with a specific luminance:
    /// Enter an integer from 0 to 2147483647, corresponding to the output's
    /// luminance. To apply this 3D LUT to any output regardless of its luminance:
    /// Leave blank, or enter 0.
    output_mastering_luminance: ?i32 = null,

    pub const json_field_names = .{
        .file_input = "FileInput",
        .input_color_space = "InputColorSpace",
        .input_mastering_luminance = "InputMasteringLuminance",
        .output_color_space = "OutputColorSpace",
        .output_mastering_luminance = "OutputMasteringLuminance",
    };
};
