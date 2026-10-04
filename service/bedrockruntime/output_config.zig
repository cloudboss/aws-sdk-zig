const OutputFormat = @import("output_format.zig").OutputFormat;

/// Output configuration for a model response in a call to
/// [Converse](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_Converse.html) or [ConverseStream](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_ConverseStream.html).
pub const OutputConfig = struct {
    /// The effort level for the model to use when generating a response. Higher
    /// effort levels allow the model to spend more time reasoning before
    /// responding. Supported values are `low`, `medium`, `high`, `xhigh`, and
    /// `max`.
    ///
    /// When extended thinking is disabled, the effort level is capped at `high`.
    /// Use effort `high` or below, or enable thinking to use higher effort levels.
    effort: ?[]const u8 = null,

    /// Structured output parameters to control the model's text response.
    text_format: ?OutputFormat = null,

    pub const json_field_names = .{
        .effort = "effort",
        .text_format = "textFormat",
    };
};
