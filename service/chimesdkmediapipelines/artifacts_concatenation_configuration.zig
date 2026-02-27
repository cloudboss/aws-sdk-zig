const AudioConcatenationConfiguration = @import("audio_concatenation_configuration.zig").AudioConcatenationConfiguration;
const CompositedVideoConcatenationConfiguration = @import("composited_video_concatenation_configuration.zig").CompositedVideoConcatenationConfiguration;
const ContentConcatenationConfiguration = @import("content_concatenation_configuration.zig").ContentConcatenationConfiguration;
const DataChannelConcatenationConfiguration = @import("data_channel_concatenation_configuration.zig").DataChannelConcatenationConfiguration;
const MeetingEventsConcatenationConfiguration = @import("meeting_events_concatenation_configuration.zig").MeetingEventsConcatenationConfiguration;
const TranscriptionMessagesConcatenationConfiguration = @import("transcription_messages_concatenation_configuration.zig").TranscriptionMessagesConcatenationConfiguration;
const VideoConcatenationConfiguration = @import("video_concatenation_configuration.zig").VideoConcatenationConfiguration;

/// The configuration for the artifacts concatenation.
pub const ArtifactsConcatenationConfiguration = struct {
    /// The configuration for the audio artifacts concatenation.
    audio: AudioConcatenationConfiguration,

    /// The configuration for the composited video artifacts concatenation.
    composited_video: CompositedVideoConcatenationConfiguration,

    /// The configuration for the content artifacts concatenation.
    content: ContentConcatenationConfiguration,

    /// The configuration for the data channel artifacts concatenation.
    data_channel: DataChannelConcatenationConfiguration,

    /// The configuration for the meeting events artifacts concatenation.
    meeting_events: MeetingEventsConcatenationConfiguration,

    /// The configuration for the transcription messages artifacts concatenation.
    transcription_messages: TranscriptionMessagesConcatenationConfiguration,

    /// The configuration for the video artifacts concatenation.
    video: VideoConcatenationConfiguration,

    pub const json_field_names = .{
        .audio = "Audio",
        .composited_video = "CompositedVideo",
        .content = "Content",
        .data_channel = "DataChannel",
        .meeting_events = "MeetingEvents",
        .transcription_messages = "TranscriptionMessages",
        .video = "Video",
    };
};
