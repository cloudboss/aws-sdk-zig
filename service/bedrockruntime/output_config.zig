const OutputFormat = @import("output_format.zig").OutputFormat;

/// Output configuration for a model response in a call to
/// [Converse](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_Converse.html) or [ConverseStream](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_ConverseStream.html).
pub const OutputConfig = struct {
    /// Structured output parameters to control the model's text response.
    text_format: ?OutputFormat = null,

    pub const json_field_names = .{
        .text_format = "textFormat",
    };
};
