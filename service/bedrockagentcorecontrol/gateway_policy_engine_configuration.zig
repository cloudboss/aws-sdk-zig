const GatewayPolicyEngineMode = @import("gateway_policy_engine_mode.zig").GatewayPolicyEngineMode;

/// The configuration for a policy engine associated with a gateway. A policy
/// engine is a collection of policies that evaluates and authorizes agent tool
/// calls. When associated with a gateway, the policy engine intercepts all
/// agent requests and determines whether to allow or deny each action based on
/// the defined policies.
pub const GatewayPolicyEngineConfiguration = struct {
    /// The ARN of the policy engine. The policy engine contains Cedar policies that
    /// define fine-grained authorization rules specifying who can perform what
    /// actions on which resources as agents interact through the gateway.
    arn: []const u8,

    /// The enforcement mode for the policy engine. Valid values include:
    ///
    /// * `LOG_ONLY` - The policy engine evaluates each action against your policies
    ///   and adds traces on whether tool calls would be allowed or denied, but does
    ///   not enforce the decision. Use this mode to test and validate policies
    ///   before enabling enforcement.
    /// * `ENFORCE` - The policy engine evaluates actions against your policies and
    ///   enforces decisions by allowing or denying agent operations. Test and
    ///   validate policies in `LOG_ONLY` mode before enabling enforcement to avoid
    ///   unintended denials or adversely affecting production traffic.
    mode: GatewayPolicyEngineMode,

    pub const json_field_names = .{
        .arn = "arn",
        .mode = "mode",
    };
};
