const BedrockFoundationModelConfigurationForParsing = @import("bedrock_foundation_model_configuration_for_parsing.zig").BedrockFoundationModelConfigurationForParsing;
const ParsingStrategy = @import("parsing_strategy.zig").ParsingStrategy;

/// Settings for parsing document contents. By default, the service converts the
/// contents of each document into text before splitting it into chunks. To
/// improve processing of PDF files with tables and images, you can configure
/// the data source to convert the pages of text into images and use a model to
/// describe the contents of each page.
pub const ParsingConfiguration = struct {
    /// Settings for a foundation model used to parse documents for a data source.
    bedrock_foundation_model_configuration: ?BedrockFoundationModelConfigurationForParsing = null,

    /// The parsing strategy for the data source.
    parsing_strategy: ParsingStrategy,

    pub const json_field_names = .{
        .bedrock_foundation_model_configuration = "bedrockFoundationModelConfiguration",
        .parsing_strategy = "parsingStrategy",
    };
};
