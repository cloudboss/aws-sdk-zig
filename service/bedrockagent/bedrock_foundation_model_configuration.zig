const ParsingModality = @import("parsing_modality.zig").ParsingModality;
const ParsingPrompt = @import("parsing_prompt.zig").ParsingPrompt;

/// Settings for a foundation model used to parse documents for a data source.
pub const BedrockFoundationModelConfiguration = struct {
    /// The ARN of the foundation model to use for parsing.
    model_arn: []const u8,

    /// Specifies whether to enable parsing of multimodal data, including both text
    /// and/or images.
    parsing_modality: ?ParsingModality,

    /// Instructions for interpreting the contents of a document.
    parsing_prompt: ?ParsingPrompt,

    pub const json_field_names = .{
        .model_arn = "modelArn",
        .parsing_modality = "parsingModality",
        .parsing_prompt = "parsingPrompt",
    };
};
