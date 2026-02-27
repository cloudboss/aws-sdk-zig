const AudioConfiguration = @import("audio_configuration.zig").AudioConfiguration;
const EmbeddingDataType = @import("embedding_data_type.zig").EmbeddingDataType;
const VideoConfiguration = @import("video_configuration.zig").VideoConfiguration;

/// The vector configuration details for the Bedrock embeddings model.
pub const BedrockEmbeddingModelConfiguration = struct {
    /// Configuration settings for processing audio content in multimodal knowledge
    /// bases.
    audio: ?[]const AudioConfiguration,

    /// The dimensions details for the vector configuration used on the Bedrock
    /// embeddings model.
    dimensions: ?i32,

    /// The data type for the vectors when using a model to convert text into vector
    /// embeddings. The model must support the specified data type for vector
    /// embeddings. Floating-point (float32) is the default data type, and is
    /// supported by most models for vector embeddings. See [Supported embeddings
    /// models](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-supported.html) for information on the available models and their vector data types.
    embedding_data_type: ?EmbeddingDataType,

    /// Configuration settings for processing video content in multimodal knowledge
    /// bases.
    video: ?[]const VideoConfiguration,

    pub const json_field_names = .{
        .audio = "audio",
        .dimensions = "dimensions",
        .embedding_data_type = "embeddingDataType",
        .video = "video",
    };
};
