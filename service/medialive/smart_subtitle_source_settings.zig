const CaptionSynchronizationMode = @import("caption_synchronization_mode.zig").CaptionSynchronizationMode;

/// Smart Subtitle Source Settings
pub const SmartSubtitleSourceSettings = struct {
    /// Controls whether MediaLive delays video to synchronize captions with audio
    /// and video output.
    caption_synchronization_mode: ?CaptionSynchronizationMode = null,

    /// The name of the Elemental Inference feed output that supplies subtitle input
    /// into this caption selector.
    inference_feed_output: ?[]const u8 = null,

    pub const json_field_names = .{
        .caption_synchronization_mode = "CaptionSynchronizationMode",
        .inference_feed_output = "InferenceFeedOutput",
    };
};
