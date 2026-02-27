const ExternalSourcesGenerationConfiguration = @import("external_sources_generation_configuration.zig").ExternalSourcesGenerationConfiguration;
const ExternalSource = @import("external_source.zig").ExternalSource;

/// The configuration of the external source wrapper object in the
/// `retrieveAndGenerate` function.
pub const ExternalSourcesRetrieveAndGenerateConfiguration = struct {
    /// Contains configurations details for response generation based on retrieved
    /// text chunks.
    generation_configuration: ?ExternalSourcesGenerationConfiguration,

    /// The Amazon Resource Name (ARN) of the foundation model or [inference
    /// profile](https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference.html) used to generate responses.
    model_arn: []const u8,

    /// The document for the external source wrapper object in the
    /// `retrieveAndGenerate` function.
    sources: []const ExternalSource,

    pub const json_field_names = .{
        .generation_configuration = "generationConfiguration",
        .model_arn = "modelArn",
        .sources = "sources",
    };
};
