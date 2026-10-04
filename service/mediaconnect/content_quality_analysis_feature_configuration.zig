const BlackFramesConfiguration = @import("black_frames_configuration.zig").BlackFramesConfiguration;
const FrozenFramesConfiguration = @import("frozen_frames_configuration.zig").FrozenFramesConfiguration;
const SilentAudioConfiguration = @import("silent_audio_configuration.zig").SilentAudioConfiguration;

/// Configures the content quality analysis features for the router input.
pub const ContentQualityAnalysisFeatureConfiguration = struct {
    /// Settings for black frames detection.
    black_frames: ?BlackFramesConfiguration = null,

    /// Settings for frozen frames detection.
    frozen_frames: ?FrozenFramesConfiguration = null,

    /// Settings for silent audio detection.
    silent_audio: ?SilentAudioConfiguration = null,

    pub const json_field_names = .{
        .black_frames = "BlackFrames",
        .frozen_frames = "FrozenFrames",
        .silent_audio = "SilentAudio",
    };
};
