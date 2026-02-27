const ColorCorrection = @import("color_correction.zig").ColorCorrection;

/// Property of encoderSettings. Controls color conversion when you are using 3D
/// LUT files to perform color conversion on video.
pub const ColorCorrectionSettings = struct {
    /// An array of colorCorrections that applies when you are using 3D LUT files to
    /// perform color conversion on video. Each colorCorrection contains one 3D LUT
    /// file (that defines the color mapping for converting an input color space to
    /// an output color space), and the input/output combination that this 3D LUT
    /// file applies to. MediaLive reads the color space in the input metadata,
    /// determines the color space that you have specified for the output, and finds
    /// and uses the LUT file that applies to this combination.
    global_color_corrections: []const ColorCorrection,

    pub const json_field_names = .{
        .global_color_corrections = "GlobalColorCorrections",
    };
};
