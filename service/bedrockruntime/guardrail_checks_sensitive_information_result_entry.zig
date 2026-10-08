const GuardrailChecksSensitiveInformationEntityType = @import("guardrail_checks_sensitive_information_entity_type.zig").GuardrailChecksSensitiveInformationEntityType;

/// The detection result for a single sensitive information entity found in the
/// evaluated messages.
pub const GuardrailChecksSensitiveInformationResultEntry = struct {
    /// The start character offset of the detected entity within the content block.
    begin_offset: i32,

    /// The confidence score for the detection, ranging from 0.0 to 1.0. Higher
    /// values indicate greater confidence.
    confidence_score: f64,

    /// The zero-based index of the content block within the message where the
    /// entity was detected.
    content_index: i32,

    /// The end character offset of the detected entity within the content block.
    end_offset: i32,

    /// The zero-based index of the message in the input messages array where the
    /// entity was detected.
    message_index: i32,

    /// The PII entity type that was detected.
    type: GuardrailChecksSensitiveInformationEntityType,

    pub const json_field_names = .{
        .begin_offset = "beginOffset",
        .confidence_score = "confidenceScore",
        .content_index = "contentIndex",
        .end_offset = "endOffset",
        .message_index = "messageIndex",
        .type = "type",
    };
};
