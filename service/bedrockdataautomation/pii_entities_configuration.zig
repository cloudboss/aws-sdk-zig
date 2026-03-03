const PIIEntityType = @import("pii_entity_type.zig").PIIEntityType;
const PIIRedactionMaskMode = @import("pii_redaction_mask_mode.zig").PIIRedactionMaskMode;

/// Configuration for PII entities detection and redaction
pub const PIIEntitiesConfiguration = struct {
    /// Types of PII entities to detect
    pii_entity_types: ?[]const PIIEntityType = null,

    /// Mode for redacting detected PII
    redaction_mask_mode: ?PIIRedactionMaskMode = null,

    pub const json_field_names = .{
        .pii_entity_types = "piiEntityTypes",
        .redaction_mask_mode = "redactionMaskMode",
    };
};
