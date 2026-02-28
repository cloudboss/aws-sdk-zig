const GuardrailWordAction = @import("guardrail_word_action.zig").GuardrailWordAction;
const GuardrailManagedWordsType = @import("guardrail_managed_words_type.zig").GuardrailManagedWordsType;

/// The managed word list to configure for the guardrail.
pub const GuardrailManagedWordsConfig = struct {
    /// Specifies the action to take when harmful content is detected in the input.
    /// Supported values include:
    ///
    /// * `BLOCK` – Block the content and replace it with blocked messaging.
    /// * `NONE` – Take no action but return detection information in the trace
    ///   response.
    input_action: ?GuardrailWordAction,

    /// Specifies whether to enable guardrail evaluation on the input. When
    /// disabled, you aren't charged for the evaluation. The evaluation doesn't
    /// appear in the response.
    input_enabled: ?bool,

    /// Specifies the action to take when harmful content is detected in the output.
    /// Supported values include:
    ///
    /// * `BLOCK` – Block the content and replace it with blocked messaging.
    /// * `NONE` – Take no action but return detection information in the trace
    ///   response.
    output_action: ?GuardrailWordAction,

    /// Specifies whether to enable guardrail evaluation on the output. When
    /// disabled, you aren't charged for the evaluation. The evaluation doesn't
    /// appear in the response.
    output_enabled: ?bool,

    /// The managed word type to configure for the guardrail.
    @"type": GuardrailManagedWordsType,

    pub const json_field_names = .{
        .input_action = "inputAction",
        .input_enabled = "inputEnabled",
        .output_action = "outputAction",
        .output_enabled = "outputEnabled",
        .@"type" = "type",
    };
};
