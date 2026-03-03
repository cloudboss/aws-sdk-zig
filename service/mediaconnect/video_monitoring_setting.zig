const BlackFrames = @import("black_frames.zig").BlackFrames;
const FrozenFrames = @import("frozen_frames.zig").FrozenFrames;

/// Specifies the configuration for video stream metrics monitoring.
pub const VideoMonitoringSetting = struct {
    /// Detects video frames that are black.
    black_frames: ?BlackFrames = null,

    /// Detects video frames that have not changed.
    frozen_frames: ?FrozenFrames = null,

    pub const json_field_names = .{
        .black_frames = "BlackFrames",
        .frozen_frames = "FrozenFrames",
    };
};
