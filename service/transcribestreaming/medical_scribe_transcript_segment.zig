const MedicalScribeTranscriptItem = @import("medical_scribe_transcript_item.zig").MedicalScribeTranscriptItem;

/// Contains a set of transcription results, along with additional information
/// of the segment.
pub const MedicalScribeTranscriptSegment = struct {
    /// The start time, in milliseconds, of the segment.
    begin_audio_time: f64 = 0,

    /// Indicates which audio channel is associated with the
    /// `MedicalScribeTranscriptSegment`.
    ///
    /// If `MedicalScribeChannelDefinition` is not provided in the
    /// `MedicalScribeConfigurationEvent`,
    /// then this field will not be included.
    channel_id: ?[]const u8,

    /// Contains transcribed text of the segment.
    content: ?[]const u8,

    /// The end time, in milliseconds, of the segment.
    end_audio_time: f64 = 0,

    /// Indicates if the segment is complete.
    ///
    /// If `IsPartial` is `true`, the segment is not complete.
    /// If `IsPartial` is `false`, the segment is complete.
    is_partial: bool = false,

    /// Contains words, phrases, or punctuation marks in your segment.
    items: ?[]const MedicalScribeTranscriptItem,

    /// The identifier of the segment.
    segment_id: ?[]const u8,

    pub const json_field_names = .{
        .begin_audio_time = "BeginAudioTime",
        .channel_id = "ChannelId",
        .content = "Content",
        .end_audio_time = "EndAudioTime",
        .is_partial = "IsPartial",
        .items = "Items",
        .segment_id = "SegmentId",
    };
};
