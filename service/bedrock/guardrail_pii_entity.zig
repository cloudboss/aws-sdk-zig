const GuardrailSensitiveInformationAction = @import("guardrail_sensitive_information_action.zig").GuardrailSensitiveInformationAction;
const GuardrailPiiEntityType = @import("guardrail_pii_entity_type.zig").GuardrailPiiEntityType;

/// The PII entity configured for the guardrail.
pub const GuardrailPiiEntity = struct {
    /// The configured guardrail action when PII entity is detected.
    action: GuardrailSensitiveInformationAction,

    /// The action to take when harmful content is detected in the input. Supported
    /// values include:
    ///
    /// * `BLOCK` – Block the content and replace it with blocked messaging.
    /// * `ANONYMIZE` – Mask the content and replace it with identifier tags.
    /// * `NONE` – Take no action but return detection information in the trace
    ///   response.
    input_action: ?GuardrailSensitiveInformationAction,

    /// Indicates whether guardrail evaluation is enabled on the input. When
    /// disabled, you aren't charged for the evaluation. The evaluation doesn't
    /// appear in the response.
    input_enabled: ?bool,

    /// The action to take when harmful content is detected in the output. Supported
    /// values include:
    ///
    /// * `BLOCK` – Block the content and replace it with blocked messaging.
    /// * `ANONYMIZE` – Mask the content and replace it with identifier tags.
    /// * `NONE` – Take no action but return detection information in the trace
    ///   response.
    output_action: ?GuardrailSensitiveInformationAction,

    /// Indicates whether guardrail evaluation is enabled on the output. When
    /// disabled, you aren't charged for the evaluation. The evaluation doesn't
    /// appear in the response.
    output_enabled: ?bool,

    /// The type of PII entity. For example, Social Security Number.
    type: GuardrailPiiEntityType,

    pub const json_field_names = .{
        .action = "action",
        .input_action = "inputAction",
        .input_enabled = "inputEnabled",
        .output_action = "outputAction",
        .output_enabled = "outputEnabled",
        .type = "type",
    };
};
