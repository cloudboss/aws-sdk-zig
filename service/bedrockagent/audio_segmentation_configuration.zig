/// Configuration for segmenting audio content during multimodal knowledge base
/// ingestion. Determines how audio files are divided into chunks for
/// processing.
pub const AudioSegmentationConfiguration = struct {
    /// The duration in seconds for each audio segment. Audio files will be divided
    /// into chunks of this length for processing.
    fixed_length_duration: i32,

    pub const json_field_names = .{
        .fixed_length_duration = "fixedLengthDuration",
    };
};
