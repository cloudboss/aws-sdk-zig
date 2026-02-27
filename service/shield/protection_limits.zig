const Limit = @import("limit.zig").Limit;

/// Limits settings on protections for your subscription.
pub const ProtectionLimits = struct {
    /// The maximum number of resource types that you can specify in a protection.
    protected_resource_type_limits: []const Limit,

    pub const json_field_names = .{
        .protected_resource_type_limits = "ProtectedResourceTypeLimits",
    };
};
