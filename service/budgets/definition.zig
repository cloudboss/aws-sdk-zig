const IamActionDefinition = @import("iam_action_definition.zig").IamActionDefinition;
const ScpActionDefinition = @import("scp_action_definition.zig").ScpActionDefinition;
const SsmActionDefinition = @import("ssm_action_definition.zig").SsmActionDefinition;

/// Specifies all of the type-specific parameters.
pub const Definition = struct {
    /// The Identity and Access Management (IAM) action definition details.
    iam_action_definition: ?IamActionDefinition,

    /// The service control policies (SCPs) action definition details.
    scp_action_definition: ?ScpActionDefinition,

    /// The Amazon Web Services Systems Manager (SSM) action definition details.
    ssm_action_definition: ?SsmActionDefinition,

    pub const json_field_names = .{
        .iam_action_definition = "IamActionDefinition",
        .scp_action_definition = "ScpActionDefinition",
        .ssm_action_definition = "SsmActionDefinition",
    };
};
