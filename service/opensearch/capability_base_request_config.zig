const AIConfig = @import("ai_config.zig").AIConfig;

/// The base configuration for registering a capability. Contains
/// capability-specific configuration such as AI settings.
pub const CapabilityBaseRequestConfig = union(enum) {
    /// Configuration settings for AI-powered capabilities.
    ai_config: ?AIConfig,

    pub const json_field_names = .{
        .ai_config = "aiConfig",
    };
};
