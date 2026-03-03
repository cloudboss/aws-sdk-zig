const EntitlementUsage = @import("entitlement_usage.zig").EntitlementUsage;

/// Describes the entitlement usage associated with a license.
pub const LicenseUsage = struct {
    /// License entitlement usages.
    entitlement_usages: ?[]const EntitlementUsage = null,

    pub const json_field_names = .{
        .entitlement_usages = "EntitlementUsages",
    };
};
