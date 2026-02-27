const QueryGenerationContext = @import("query_generation_context.zig").QueryGenerationContext;

/// Contains configurations for query generation. For more information, see
/// [Build a knowledge base by connecting to a structured data
/// source](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-build-structured.html) in the Amazon Bedrock User Guide..
pub const QueryGenerationConfiguration = struct {
    /// The time after which query generation will time out.
    execution_timeout_seconds: ?i32,

    /// Specifies configurations for context to use during query generation.
    generation_context: ?QueryGenerationContext,

    pub const json_field_names = .{
        .execution_timeout_seconds = "executionTimeoutSeconds",
        .generation_context = "generationContext",
    };
};
