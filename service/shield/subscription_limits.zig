const ProtectionGroupLimits = @import("protection_group_limits.zig").ProtectionGroupLimits;
const ProtectionLimits = @import("protection_limits.zig").ProtectionLimits;

/// Limits settings for your subscription.
pub const SubscriptionLimits = struct {
    /// Limits settings on protection groups for your subscription.
    protection_group_limits: ProtectionGroupLimits,

    /// Limits settings on protections for your subscription.
    protection_limits: ProtectionLimits,

    pub const json_field_names = .{
        .protection_group_limits = "ProtectionGroupLimits",
        .protection_limits = "ProtectionLimits",
    };
};
