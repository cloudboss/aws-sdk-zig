const Fmp4NielsenId3Behavior = @import("fmp_4_nielsen_id_3_behavior.zig").Fmp4NielsenId3Behavior;
const Fmp4TimedMetadataBehavior = @import("fmp_4_timed_metadata_behavior.zig").Fmp4TimedMetadataBehavior;

/// Fmp4 Hls Settings
pub const Fmp4HlsSettings = struct {
    /// List all the audio groups that are used with the video output stream. Input
    /// all the audio GROUP-IDs that are associated to the video, separate by ','.
    audio_rendition_sets: ?[]const u8 = null,

    /// If set to passthrough, Nielsen inaudible tones for media tracking will be
    /// detected in the input audio and an equivalent ID3 tag will be inserted in
    /// the output.
    nielsen_id_3_behavior: ?Fmp4NielsenId3Behavior = null,

    /// Set to PASSTHROUGH to enable ID3 metadata insertion. To include metadata,
    /// you configure other parameters in the output group or individual outputs, or
    /// you add an ID3 action to the channel schedule.
    timed_metadata_behavior: ?Fmp4TimedMetadataBehavior = null,

    pub const json_field_names = .{
        .audio_rendition_sets = "AudioRenditionSets",
        .nielsen_id_3_behavior = "NielsenId3Behavior",
        .timed_metadata_behavior = "TimedMetadataBehavior",
    };
};
