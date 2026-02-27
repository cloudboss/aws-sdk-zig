const ChannelLabelingConfiguration = @import("channel_labeling_configuration.zig").ChannelLabelingConfiguration;
const SpeakerLabelingConfiguration = @import("speaker_labeling_configuration.zig").SpeakerLabelingConfiguration;

/// Configuration for transcript related features
pub const TranscriptConfiguration = struct {
    channel_labeling: ?ChannelLabelingConfiguration,

    speaker_labeling: ?SpeakerLabelingConfiguration,

    pub const json_field_names = .{
        .channel_labeling = "channelLabeling",
        .speaker_labeling = "speakerLabeling",
    };
};
