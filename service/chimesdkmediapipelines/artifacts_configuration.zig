const AudioArtifactsConfiguration = @import("audio_artifacts_configuration.zig").AudioArtifactsConfiguration;
const CompositedVideoArtifactsConfiguration = @import("composited_video_artifacts_configuration.zig").CompositedVideoArtifactsConfiguration;
const ContentArtifactsConfiguration = @import("content_artifacts_configuration.zig").ContentArtifactsConfiguration;
const VideoArtifactsConfiguration = @import("video_artifacts_configuration.zig").VideoArtifactsConfiguration;

/// The configuration for the artifacts.
pub const ArtifactsConfiguration = struct {
    /// The configuration for the audio artifacts.
    audio: AudioArtifactsConfiguration,

    /// Enables video compositing.
    composited_video: ?CompositedVideoArtifactsConfiguration = null,

    /// The configuration for the content artifacts.
    content: ContentArtifactsConfiguration,

    /// The configuration for the video artifacts.
    video: VideoArtifactsConfiguration,

    pub const json_field_names = .{
        .audio = "Audio",
        .composited_video = "CompositedVideo",
        .content = "Content",
        .video = "Video",
    };
};
