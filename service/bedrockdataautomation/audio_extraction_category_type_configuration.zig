const TranscriptConfiguration = @import("transcript_configuration.zig").TranscriptConfiguration;

/// Configuration for different audio extraction category types
pub const AudioExtractionCategoryTypeConfiguration = struct {
    transcript: ?TranscriptConfiguration,

    pub const json_field_names = .{
        .transcript = "transcript",
    };
};
