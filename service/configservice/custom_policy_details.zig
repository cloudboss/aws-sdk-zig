/// Provides the runtime system, policy definition, and whether debug logging
/// enabled. You can
/// specify the following CustomPolicyDetails parameter values
/// only
/// for Config Custom Policy rules.
pub const CustomPolicyDetails = struct {
    /// The boolean expression for enabling debug logging for your Config Custom
    /// Policy rule. The default value is `false`.
    enable_debug_log_delivery: bool = false,

    /// The runtime system for your Config Custom Policy rule. Guard is a
    /// policy-as-code language that allows you to write policies that are enforced
    /// by Config Custom Policy rules. For more information about Guard, see the
    /// [Guard GitHub
    /// Repository](https://github.com/aws-cloudformation/cloudformation-guard).
    policy_runtime: []const u8,

    /// The policy definition containing the logic for your Config Custom Policy
    /// rule.
    policy_text: []const u8,

    pub const json_field_names = .{
        .enable_debug_log_delivery = "EnableDebugLogDelivery",
        .policy_runtime = "PolicyRuntime",
        .policy_text = "PolicyText",
    };
};
