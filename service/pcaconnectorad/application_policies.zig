const ApplicationPolicy = @import("application_policy.zig").ApplicationPolicy;

/// Application policies describe what the certificate can be used for.
pub const ApplicationPolicies = struct {
    /// Marks the application policy extension as critical.
    critical: ?bool,

    /// Application policies describe what the certificate can be used for.
    policies: []const ApplicationPolicy,

    pub const json_field_names = .{
        .critical = "Critical",
        .policies = "Policies",
    };
};
