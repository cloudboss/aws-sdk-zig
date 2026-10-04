const RemediationParameter = @import("remediation_parameter.zig").RemediationParameter;
const RemediationStep = @import("remediation_step.zig").RemediationStep;

/// The specification of the remediation target guidance. This outlines required
/// resource parameters
/// and permissions, remediation steps, and the end state.
pub const RemediationGuidanceSpecification = struct {
    /// The expected end state of the associated resources after completion of the
    /// steps.
    expected_end_state: ?[]const u8 = null,

    /// An array of the parameters used in running the steps provided.
    parameters: ?[]const RemediationParameter = null,

    /// An array of required permissions to run the steps.
    required_permissions: ?[]const []const u8 = null,

    /// An array of ordered steps for resolving the remediation targets.
    steps: ?[]const RemediationStep = null,

    pub const json_field_names = .{
        .expected_end_state = "ExpectedEndState",
        .parameters = "Parameters",
        .required_permissions = "RequiredPermissions",
        .steps = "Steps",
    };
};
