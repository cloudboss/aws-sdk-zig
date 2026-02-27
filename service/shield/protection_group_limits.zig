const ProtectionGroupPatternTypeLimits = @import("protection_group_pattern_type_limits.zig").ProtectionGroupPatternTypeLimits;

/// Limits settings on protection groups for your subscription.
pub const ProtectionGroupLimits = struct {
    /// The maximum number of protection groups that you can have at one time.
    max_protection_groups: i64 = 0,

    /// Limits settings by pattern type in the protection groups for your
    /// subscription.
    pattern_type_limits: ProtectionGroupPatternTypeLimits,

    pub const json_field_names = .{
        .max_protection_groups = "MaxProtectionGroups",
        .pattern_type_limits = "PatternTypeLimits",
    };
};
