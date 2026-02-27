const ParsingPrompt = @import("parsing_prompt.zig").ParsingPrompt;

/// Settings for a foundation model used to parse documents for a data source.
pub const BedrockFoundationModelConfigurationForParsing = struct {
    /// The ARN of the foundation model.
    model_arn: []const u8,

    /// Instructions for interpreting the contents of a document.
    parsing_prompt: ?ParsingPrompt,

    pub const json_field_names = .{
        .model_arn = "modelArn",
        .parsing_prompt = "parsingPrompt",
    };
};
