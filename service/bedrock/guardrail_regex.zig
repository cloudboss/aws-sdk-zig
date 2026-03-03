const GuardrailSensitiveInformationAction = @import("guardrail_sensitive_information_action.zig").GuardrailSensitiveInformationAction;

/// The regular expression configured for the guardrail.
pub const GuardrailRegex = struct {
    /// The action taken when a match to the regular expression is detected.
    action: GuardrailSensitiveInformationAction,

    /// The description of the regular expression for the guardrail.
    description: ?[]const u8 = null,

    /// The action to take when harmful content is detected in the input. Supported
    /// values include:
    ///
    /// * `BLOCK` – Block the content and replace it with blocked messaging.
    /// * `NONE` – Take no action but return detection information in the trace
    ///   response.
    input_action: ?GuardrailSensitiveInformationAction = null,

    /// Indicates whether guardrail evaluation is enabled on the input. When
    /// disabled, you aren't charged for the evaluation. The evaluation doesn't
    /// appear in the response.
    input_enabled: ?bool = null,

    /// The name of the regular expression for the guardrail.
    name: []const u8,

    /// The action to take when harmful content is detected in the output. Supported
    /// values include:
    ///
    /// * `BLOCK` – Block the content and replace it with blocked messaging.
    /// * `NONE` – Take no action but return detection information in the trace
    ///   response.
    output_action: ?GuardrailSensitiveInformationAction = null,

    /// Indicates whether guardrail evaluation is enabled on the output. When
    /// disabled, you aren't charged for the evaluation. The evaluation doesn't
    /// appear in the response.
    output_enabled: ?bool = null,

    /// The pattern of the regular expression configured for the guardrail.
    pattern: []const u8,

    pub const json_field_names = .{
        .action = "action",
        .description = "description",
        .input_action = "inputAction",
        .input_enabled = "inputEnabled",
        .name = "name",
        .output_action = "outputAction",
        .output_enabled = "outputEnabled",
        .pattern = "pattern",
    };
};
