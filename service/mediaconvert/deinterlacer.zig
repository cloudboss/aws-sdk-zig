const DeinterlaceAlgorithm = @import("deinterlace_algorithm.zig").DeinterlaceAlgorithm;
const DeinterlacerControl = @import("deinterlacer_control.zig").DeinterlacerControl;
const DeinterlacerMode = @import("deinterlacer_mode.zig").DeinterlacerMode;

/// Settings for deinterlacer
pub const Deinterlacer = struct {
    /// Only applies when you set Deinterlace mode to Deinterlace or Adaptive.
    /// Interpolate produces sharper pictures, while blend produces smoother motion.
    /// If your source file includes a ticker, such as a scrolling headline at the
    /// bottom of the frame: Choose Interpolate ticker or Blend ticker. To apply
    /// field doubling: Choose Linear interpolation. Note that Linear interpolation
    /// may introduce video artifacts into your output.
    algorithm: ?DeinterlaceAlgorithm = null,

    /// - When set to NORMAL (default), the deinterlacer does not convert frames
    /// that are tagged in metadata as progressive. It will only convert those that
    /// are tagged as some other type. - When set to FORCE_ALL_FRAMES, the
    /// deinterlacer converts every frame to progressive - even those that are
    /// already tagged as progressive. Turn Force mode on only if there is a good
    /// chance that the metadata has tagged frames as progressive when they are not
    /// progressive. Do not turn on otherwise; processing frames that are already
    /// progressive into progressive will probably result in lower quality video.
    control: ?DeinterlacerControl = null,

    /// Use Deinterlacer to choose how the service will do deinterlacing. Default is
    /// Deinterlace.
    /// - Deinterlace converts interlaced to progressive.
    /// - Inverse telecine converts Hard Telecine 29.97i to progressive 23.976p.
    /// - Adaptive auto-detects and converts to progressive.
    mode: ?DeinterlacerMode = null,

    pub const json_field_names = .{
        .algorithm = "Algorithm",
        .control = "Control",
        .mode = "Mode",
    };
};
