const ProtectionGroupArbitraryPatternLimits = @import("protection_group_arbitrary_pattern_limits.zig").ProtectionGroupArbitraryPatternLimits;

/// Limits settings by pattern type in the protection groups for your
/// subscription.
pub const ProtectionGroupPatternTypeLimits = struct {
    /// Limits settings on protection groups with arbitrary pattern type.
    arbitrary_pattern_limits: ProtectionGroupArbitraryPatternLimits,

    pub const json_field_names = .{
        .arbitrary_pattern_limits = "ArbitraryPatternLimits",
    };
};
