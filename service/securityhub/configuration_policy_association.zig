const Target = @import("target.zig").Target;

/// Provides details about the association between an Security Hub CSPM
/// configuration and a target account, organizational unit, or
/// the root. An association can exist between a target and a configuration
/// policy, or between a target and self-managed
/// behavior.
pub const ConfigurationPolicyAssociation = struct {
    /// The target account, organizational unit, or the root.
    target: ?Target = null,

    pub const json_field_names = .{
        .target = "Target",
    };
};
