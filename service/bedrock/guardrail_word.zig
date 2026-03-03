const GuardrailWordAction = @import("guardrail_word_action.zig").GuardrailWordAction;

/// A word configured for the guardrail.
pub const GuardrailWord = struct {
    /// The action to take when harmful content is detected in the input. Supported
    /// values include:
    ///
    /// * `BLOCK` – Block the content and replace it with blocked messaging.
    /// * `NONE` – Take no action but return detection information in the trace
    ///   response.
    input_action: ?GuardrailWordAction = null,

    /// Indicates whether guardrail evaluation is enabled on the input. When
    /// disabled, you aren't charged for the evaluation. The evaluation doesn't
    /// appear in the response.
    input_enabled: ?bool = null,

    /// The action to take when harmful content is detected in the output. Supported
    /// values include:
    ///
    /// * `BLOCK` – Block the content and replace it with blocked messaging.
    /// * `NONE` – Take no action but return detection information in the trace
    ///   response.
    output_action: ?GuardrailWordAction = null,

    /// Indicates whether guardrail evaluation is enabled on the output. When
    /// disabled, you aren't charged for the evaluation. The evaluation doesn't
    /// appear in the response.
    output_enabled: ?bool = null,

    /// Text of the word configured for the guardrail to block.
    text: []const u8,

    pub const json_field_names = .{
        .input_action = "inputAction",
        .input_enabled = "inputEnabled",
        .output_action = "outputAction",
        .output_enabled = "outputEnabled",
        .text = "text",
    };
};
