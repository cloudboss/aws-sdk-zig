const NaturalLanguageQueryGenerationOptionsInput = @import("natural_language_query_generation_options_input.zig").NaturalLanguageQueryGenerationOptionsInput;
const S3VectorsEngine = @import("s3_vectors_engine.zig").S3VectorsEngine;
const ServerlessVectorAcceleration = @import("serverless_vector_acceleration.zig").ServerlessVectorAcceleration;

/// Container for parameters required to enable all machine learning features.
pub const AIMLOptionsInput = struct {
    /// Container for parameters required for natural language query generation on
    /// the
    /// specified domain.
    natural_language_query_generation_options: ?NaturalLanguageQueryGenerationOptionsInput = null,

    /// Container for parameters required to enable S3 vectors engine features on
    /// the
    /// specified domain.
    s3_vectors_engine: ?S3VectorsEngine = null,

    /// Specifies whether to enable serverless vector acceleration for the domain.
    /// When enabled,
    /// provides
    /// [GPU-accelerated](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/gpu-acceleration-vector-index.html) vector search capabilities for improved performance on vector
    /// workloads.
    serverless_vector_acceleration: ?ServerlessVectorAcceleration = null,

    pub const json_field_names = .{
        .natural_language_query_generation_options = "NaturalLanguageQueryGenerationOptions",
        .s3_vectors_engine = "S3VectorsEngine",
        .serverless_vector_acceleration = "ServerlessVectorAcceleration",
    };
};
