const DetectionRuleRuntimePlatforms = @import("detection_rule_runtime_platforms.zig").DetectionRuleRuntimePlatforms;

/// Contains Runtime Monitoring-specific details for a custom detection rule.
pub const DetectionRuleRuntimeMonitoringDetails = struct {
    /// The platforms on which the rule can run. The presence of a platform member
    /// indicates that the rule is supported on that platform; the absence of a
    /// member indicates that the rule cannot run on that platform at any agent
    /// version.
    platforms: ?DetectionRuleRuntimePlatforms = null,

    pub const json_field_names = .{
        .platforms = "Platforms",
    };
};
