const PolicyParameter = @import("policy_parameter.zig").PolicyParameter;

/// Contains information about the permissions being delegated in a delegation
/// request.
pub const DelegationPermission = struct {
    /// A list of policy parameters that define the scope and constraints of the
    /// delegated permissions.
    parameters: ?[]const PolicyParameter,

    /// This ARN maps to a pre-registered policy content for this partner.
    /// See the partner onboarding documentation to understand how to create a
    /// delegation template.
    policy_template_arn: ?[]const u8,
};
