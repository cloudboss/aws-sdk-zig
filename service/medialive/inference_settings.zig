const AudioFeedInput = @import("audio_feed_input.zig").AudioFeedInput;
const EnrichmentMethod = @import("enrichment_method.zig").EnrichmentMethod;

/// Configures Elemental Inference features in a channel.
pub const InferenceSettings = struct {
    /// A list of audio feed inputs that map audio selectors in the channel to feed
    /// inputs on the associated Elemental Inference feed.
    audio_feed_inputs: ?[]const AudioFeedInput = null,

    /// The set of Contextual Metadata Enrichment methods enabled for this channel.
    /// Each method represents a specific way the channel will use the inference
    /// feed to augment its output with contextual metadata. An empty array (or
    /// omitting the field) disables enrichment. Order is not significant; duplicate
    /// values are not permitted.
    enrichment_methods: ?[]const EnrichmentMethod = null,

    /// The ARN of the feed resource that is associated with this channel. The feed
    /// is a resource in the Elemental Inference service.
    feed_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .audio_feed_inputs = "AudioFeedInputs",
        .enrichment_methods = "EnrichmentMethods",
        .feed_arn = "FeedArn",
    };
};
