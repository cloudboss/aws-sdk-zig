const AutoDetectionScope = @import("auto_detection_scope.zig").AutoDetectionScope;

/// The customer-defined auto-detection settings for a registry.
pub const AutoDetectionConfiguration = struct {
    /// Specifies whether auto-detection is requested for the registry. Setting this
    /// to `true` is necessary but not sufficient for auto-detection to become
    /// active; the preconditions of the configured scope must also be met.
    enabled: bool,

    /// The source from which resources are detected. For example, `ORGANIZATION`
    /// sources resources from all member accounts of an Amazon Web Services
    /// organization.
    scope: AutoDetectionScope,

    pub const json_field_names = .{
        .enabled = "enabled",
        .scope = "scope",
    };
};
