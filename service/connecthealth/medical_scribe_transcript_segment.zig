/// A segment of transcript text with timing and channel information
pub const MedicalScribeTranscriptSegment = struct {
    /// The offset from audio start when the audio for this segment begins
    audio_begin_offset: ?f64 = null,

    /// The offset from audio start when the audio for this segment ends
    audio_end_offset: ?f64 = null,

    /// The channel identifier for this segment
    channel_id: ?[]const u8 = null,

    /// The transcript text content
    content: ?[]const u8 = null,

    /// Indicates whether this is a partial or final transcript
    is_partial: ?bool = null,

    /// The unique identifier for this segment
    segment_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .audio_begin_offset = "audioBeginOffset",
        .audio_end_offset = "audioEndOffset",
        .channel_id = "channelId",
        .content = "content",
        .is_partial = "isPartial",
        .segment_id = "segmentId",
    };
};
