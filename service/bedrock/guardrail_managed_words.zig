const GuardrailWordAction = @import("guardrail_word_action.zig").GuardrailWordAction;
const GuardrailManagedWordsType = @import("guardrail_managed_words_type.zig").GuardrailManagedWordsType;

/// The managed word list that was configured for the guardrail. (This is a list
/// of words that are pre-defined and managed by guardrails only.)
pub const GuardrailManagedWords = struct {
    /// The action to take when harmful content is detected in the input. Supported
    /// values include:
    ///
    /// * `BLOCK` – Block the content and replace it with blocked messaging.
    /// * `NONE` – Take no action but return detection information in the trace
    ///   response.
    input_action: ?GuardrailWordAction,

    /// Indicates whether guardrail evaluation is enabled on the input. When
    /// disabled, you aren't charged for the evaluation. The evaluation doesn't
    /// appear in the response.
    input_enabled: ?bool,

    /// The action to take when harmful content is detected in the output. Supported
    /// values include:
    ///
    /// * `BLOCK` – Block the content and replace it with blocked messaging.
    /// * `NONE` – Take no action but return detection information in the trace
    ///   response.
    output_action: ?GuardrailWordAction,

    /// Indicates whether guardrail evaluation is enabled on the output. When
    /// disabled, you aren't charged for the evaluation. The evaluation doesn't
    /// appear in the response.
    output_enabled: ?bool,

    /// ManagedWords$type The managed word type that was configured for the
    /// guardrail. (For now, we only offer profanity word list)
    @"type": GuardrailManagedWordsType,

    pub const json_field_names = .{
        .input_action = "inputAction",
        .input_enabled = "inputEnabled",
        .output_action = "outputAction",
        .output_enabled = "outputEnabled",
        .@"type" = "type",
    };
};
