const ExternalSourcesGenerationConfiguration = @import("external_sources_generation_configuration.zig").ExternalSourcesGenerationConfiguration;
const ExternalSource = @import("external_source.zig").ExternalSource;

/// The configurations of the external source wrapper object in the
/// `retrieveAndGenerate` function.
pub const ExternalSourcesRetrieveAndGenerateConfiguration = struct {
    /// The prompt used with the external source wrapper object with the
    /// `retrieveAndGenerate` function.
    generation_configuration: ?ExternalSourcesGenerationConfiguration = null,

    /// The model Amazon Resource Name (ARN) for the external source wrapper object
    /// in the `retrieveAndGenerate` function.
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
