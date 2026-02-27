const ParsingModality = @import("parsing_modality.zig").ParsingModality;

/// Contains configurations for using Amazon Bedrock Data Automation as the
/// parser for ingesting your data sources.
pub const BedrockDataAutomationConfiguration = struct {
    /// Specifies whether to enable parsing of multimodal data, including both text
    /// and/or images.
    parsing_modality: ?ParsingModality,

    pub const json_field_names = .{
        .parsing_modality = "parsingModality",
    };
};
