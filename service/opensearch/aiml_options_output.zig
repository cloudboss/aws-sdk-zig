const NaturalLanguageQueryGenerationOptionsOutput = @import("natural_language_query_generation_options_output.zig").NaturalLanguageQueryGenerationOptionsOutput;
const S3VectorsEngine = @import("s3_vectors_engine.zig").S3VectorsEngine;
const ServerlessVectorAcceleration = @import("serverless_vector_acceleration.zig").ServerlessVectorAcceleration;

/// Container for parameters representing the state of machine learning features
/// on the
/// specified domain.
pub const AIMLOptionsOutput = struct {
    /// Container for parameters required for natural language query generation on
    /// the
    /// specified domain.
    natural_language_query_generation_options: ?NaturalLanguageQueryGenerationOptionsOutput,

    /// Container for parameters representing the state of S3 vectors engine
    /// features on the
    /// specified domain.
    s3_vectors_engine: ?S3VectorsEngine,

    /// The current serverless vector acceleration configuration for the domain.
    serverless_vector_acceleration: ?ServerlessVectorAcceleration,

    pub const json_field_names = .{
        .natural_language_query_generation_options = "NaturalLanguageQueryGenerationOptions",
        .s3_vectors_engine = "S3VectorsEngine",
        .serverless_vector_acceleration = "ServerlessVectorAcceleration",
    };
};
