const AIConfig = @import("ai_config.zig").AIConfig;

/// The base configuration returned for a registered capability.
pub const CapabilityBaseResponseConfig = union(enum) {
    /// Configuration settings for AI-powered capabilities.
    ai_config: ?AIConfig,

    pub const json_field_names = .{
        .ai_config = "aiConfig",
    };
};
