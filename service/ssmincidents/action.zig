const SsmAutomation = @import("ssm_automation.zig").SsmAutomation;

/// The action that starts at the beginning of an incident. The response plan
/// defines the
/// action.
pub const Action = union(enum) {
    /// The Systems Manager automation document to start as the runbook at the
    /// beginning of the
    /// incident.
    ssm_automation: ?SsmAutomation,

    pub const json_field_names = .{
        .ssm_automation = "ssmAutomation",
    };
};
