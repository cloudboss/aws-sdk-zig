/// Configuration for segmenting video content during multimodal knowledge base
/// ingestion. Determines how video files are divided into chunks for
/// processing.
pub const VideoSegmentationConfiguration = struct {
    /// The duration in seconds for each video segment. Video files will be divided
    /// into chunks of this length for processing.
    fixed_length_duration: i32,

    pub const json_field_names = .{
        .fixed_length_duration = "fixedLengthDuration",
    };
};
