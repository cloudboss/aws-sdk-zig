const CustomEntityConfig = @import("custom_entity_config.zig").CustomEntityConfig;
const EntityType = @import("entity_type.zig").EntityType;

/// The configuration for log redaction.
pub const LogRedactionConfiguration = struct {
    /// Specifies the configuration for custom entities in the context of log
    /// redaction.
    custom_entity_config: ?CustomEntityConfig,

    /// Specifies the entities to be redacted from logs. Entities to redact are
    /// "ALL_PERSONALLY_IDENTIFIABLE_INFORMATION", "NUMBERS","CUSTOM". If CUSTOM is
    /// supplied or configured, custom patterns (customDataIdentifiers) should be
    /// provided, and the patterns will be redacted in logs or error messages.
    entities_to_redact: []const EntityType,

    pub const json_field_names = .{
        .custom_entity_config = "customEntityConfig",
        .entities_to_redact = "entitiesToRedact",
    };
};
