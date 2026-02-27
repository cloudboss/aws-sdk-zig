const SensitiveDataDetectionMode = @import("sensitive_data_detection_mode.zig").SensitiveDataDetectionMode;
const SensitiveDataDetectionScopeType = @import("sensitive_data_detection_scope_type.zig").SensitiveDataDetectionScopeType;
const PIIEntitiesConfiguration = @import("pii_entities_configuration.zig").PIIEntitiesConfiguration;

/// Configuration for sensitive data detection and redaction
pub const SensitiveDataConfiguration = struct {
    /// Mode for sensitive data detection
    detection_mode: SensitiveDataDetectionMode,

    /// Scope of detection - what types of sensitive data to detect
    detection_scope: ?[]const SensitiveDataDetectionScopeType,

    /// Configuration for PII entities detection and redaction
    pii_entities_configuration: ?PIIEntitiesConfiguration,

    pub const json_field_names = .{
        .detection_mode = "detectionMode",
        .detection_scope = "detectionScope",
        .pii_entities_configuration = "piiEntitiesConfiguration",
    };
};
