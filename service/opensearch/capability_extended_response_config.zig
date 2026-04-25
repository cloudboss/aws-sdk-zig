const AIConfig = @import("ai_config.zig").AIConfig;

/// The extended configuration returned for a registered capability, including
/// additional details beyond the base configuration.
pub const CapabilityExtendedResponseConfig = union(enum) {
    /// Configuration settings for AI-powered capabilities.
    ai_config: ?AIConfig,

    pub const json_field_names = .{
        .ai_config = "aiConfig",
    };
};
