const AudioConfiguration = @import("audio_configuration.zig").AudioConfiguration;
const EmbeddingDataType = @import("embedding_data_type.zig").EmbeddingDataType;
const VideoConfiguration = @import("video_configuration.zig").VideoConfiguration;

/// The vector configuration details for the Bedrock embeddings model.
pub const BedrockEmbeddingModelConfiguration = struct {
    /// Configuration settings for processing audio content in multimodal knowledge
    /// bases.
    ///
    /// This field is deprecated. Use `modelConfiguration` instead.
    audio: ?[]const AudioConfiguration = null,

    /// The dimensions details for the vector configuration used on the Bedrock
    /// embeddings model.
    dimensions: ?i32 = null,

    /// The data type for the vectors when using a model to convert text into vector
    /// embeddings. The model must support the specified data type for vector
    /// embeddings. Floating-point (float32) is the default data type, and is
    /// supported by most models for vector embeddings. See [Supported embeddings
    /// models](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-supported.html) for information on the available models and their vector data types.
    embedding_data_type: ?EmbeddingDataType = null,

    /// Model-specific configuration for the embedding model, provided as a JSON
    /// object. Use this field to specify settings that apply to the embedding model
    /// that you selected, such as how audio and video files are divided into
    /// segments.
    ///
    /// The fields that this object accepts depend on the embedding model. For the
    /// settings that each model accepts, see the documentation for that model.
    ///
    /// For an example of a
    /// [CreateKnowledgeBase](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_CreateKnowledgeBase.html) request that uses this field to configure a multimodal embedding model, see the [Examples](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_CreateKnowledgeBase.html#API_agent_CreateKnowledgeBase_Examples) section of [CreateKnowledgeBase](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_CreateKnowledgeBase.html).
    model_configuration: ?[]const u8 = null,

    /// Configuration settings for processing video content in multimodal knowledge
    /// bases.
    ///
    /// This field is deprecated. Use `modelConfiguration` instead.
    video: ?[]const VideoConfiguration = null,

    pub const json_field_names = .{
        .audio = "audio",
        .dimensions = "dimensions",
        .embedding_data_type = "embeddingDataType",
        .model_configuration = "modelConfiguration",
        .video = "video",
    };
};
