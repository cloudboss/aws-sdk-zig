/// Maps an audio selector in the channel to a feed input on the associated
/// Elemental Inference feed.
pub const AudioFeedInput = struct {
    /// The name of the audio selector in the channel that will be sent to the
    /// Elemental Inference feed input.
    audio_selector_name: ?[]const u8 = null,

    /// The name of the feed input on the Elemental Inference feed that will receive
    /// the audio from the specified audio selector.
    feed_input: ?[]const u8 = null,

    pub const json_field_names = .{
        .audio_selector_name = "AudioSelectorName",
        .feed_input = "FeedInput",
    };
};
