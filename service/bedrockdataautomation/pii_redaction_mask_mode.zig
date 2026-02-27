/// Mode for redacting detected PII
pub const PIIRedactionMaskMode = enum {
    /// Replace with generic PII marker [PII]
    pii,
    /// Replace with specific entity type marker, e.g. [NAME]/[SSN] etc.
    entity_type,

    pub const json_field_names = .{
        .pii = "PII",
        .entity_type = "ENTITY_TYPE",
    };
};
