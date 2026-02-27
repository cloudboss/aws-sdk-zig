const AudioExtractionStatus = @import("audio_extraction_status.zig").AudioExtractionStatus;

/// Configuration settings for audio content extraction and processing.
pub const AudioExtractionConfiguration = struct {
    /// The status of audio extraction (ENABLED or DISABLED) for processing audio
    /// content from files.
    audio_extraction_status: AudioExtractionStatus,

    pub const json_field_names = .{
        .audio_extraction_status = "audioExtractionStatus",
    };
};
