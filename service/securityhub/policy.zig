const SecurityHubPolicy = @import("security_hub_policy.zig").SecurityHubPolicy;

/// An object that defines how Security Hub CSPM is configured. It includes
/// whether Security Hub CSPM is
/// enabled or disabled, a list of enabled security standards, a list of enabled
/// or disabled security controls, and a list of custom parameter values for
/// specified controls.
/// If you provide a list of security controls that are enabled in the
/// configuration policy, Security Hub CSPM
/// disables all other controls (including newly released controls). If you
/// provide a list of security controls that
/// are disabled in the configuration policy, Security Hub CSPM enables all
/// other controls (including newly
/// released controls).
pub const Policy = union(enum) {
    /// The Amazon Web Services service that the configuration policy applies to.
    security_hub: ?SecurityHubPolicy,

    pub const json_field_names = .{
        .security_hub = "SecurityHub",
    };
};
