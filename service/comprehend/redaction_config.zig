const PiiEntitiesDetectionMaskMode = @import("pii_entities_detection_mask_mode.zig").PiiEntitiesDetectionMaskMode;
const PiiEntityType = @import("pii_entity_type.zig").PiiEntityType;

/// Provides configuration parameters for PII entity redaction.
pub const RedactionConfig = struct {
    /// A character that replaces each character in the redacted PII entity.
    mask_character: ?[]const u8 = null,

    /// Specifies whether the PII entity is redacted with the mask character or the
    /// entity
    /// type.
    mask_mode: ?PiiEntitiesDetectionMaskMode = null,

    /// An array of the types of PII entities that Amazon Comprehend detects in the
    /// input text for
    /// your request.
    pii_entity_types: ?[]const PiiEntityType = null,

    pub const json_field_names = .{
        .mask_character = "MaskCharacter",
        .mask_mode = "MaskMode",
        .pii_entity_types = "PiiEntityTypes",
    };
};
