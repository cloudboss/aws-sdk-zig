const AudioExtractionStatus = @import("audio_extraction_status.zig").AudioExtractionStatus;

/// The configuration for audio extraction from knowledge base documents.
pub const AudioExtractionConfiguration = struct {
    /// The status of audio extraction. Valid values are ENABLED and DISABLED.
    audio_extraction_status: AudioExtractionStatus,

    pub const json_field_names = .{
        .audio_extraction_status = "audioExtractionStatus",
    };
};
