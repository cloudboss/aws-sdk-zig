const AudioChannelTag = @import("audio_channel_tag.zig").AudioChannelTag;

/// Specify the QuickTime audio channel layout tags for the audio channels in
/// this audio track. When you don't specify a value, MediaConvert labels your
/// track as Center (C) by default. To use Audio layout tagging, your output
/// must be in a QuickTime (MOV) container and your audio codec must be AAC,
/// WAV, or AIFF.
pub const AudioChannelTaggingSettings = struct {
    /// Specify the QuickTime audio channel layout tags for the audio channels in
    /// this audio track. Enter channel layout tags in the same order as your
    /// output's audio channel order. For example, if your output audio track has a
    /// left and a right channel, enter Left (L) for the first channel and Right (R)
    /// for the second. If your output has multiple single-channel audio tracks,
    /// enter a single channel layout tag for each track.
    channel_tag: ?AudioChannelTag = null,

    /// Specify the QuickTime audio channel layout tags for the audio channels in
    /// this audio track. Enter channel layout tags in the same order as your
    /// output's audio channel order. For example, if your output audio track has a
    /// left and a right channel, enter Left (L) for the first channel and Right (R)
    /// for the second. If your output has multiple single-channel audio tracks,
    /// enter a single channel layout tag for each track.
    channel_tags: ?[]const AudioChannelTag = null,

    pub const json_field_names = .{
        .channel_tag = "ChannelTag",
        .channel_tags = "ChannelTags",
    };
};
