const AudioExtractionType = @import("audio_extraction_type.zig").AudioExtractionType;

/// Details about an audio source, including its identifier, format, and time
/// information.
pub const AudioSourceDetails = struct {
    /// The type of audio extraction performed on the content.
    audio_extraction_type: ?AudioExtractionType,

    /// The ending timestamp in milliseconds for the relevant audio segment.
    end_time_milliseconds: ?i64,

    /// Unique identifier for the audio media file.
    media_id: ?[]const u8,

    /// The MIME type of the audio file (e.g., audio/mp3, audio/wav).
    media_mime_type: ?[]const u8,

    /// The starting timestamp in milliseconds for the relevant audio segment.
    start_time_milliseconds: ?i64,

    pub const json_field_names = .{
        .audio_extraction_type = "audioExtractionType",
        .end_time_milliseconds = "endTimeMilliseconds",
        .media_id = "mediaId",
        .media_mime_type = "mediaMimeType",
        .start_time_milliseconds = "startTimeMilliseconds",
    };
};
