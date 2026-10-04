/// Configuration for customer-managed compute capacity for the AgentCore
/// Runtime. A capacity provider runs the AgentCore Runtime on the Instances
/// compute type, using Amazon Web Services managed compute in your account.
pub const CapacityProviderConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the capacity provider to use for the
    /// AgentCore Runtime.
    capacity_provider_arn: []const u8,

    pub const json_field_names = .{
        .capacity_provider_arn = "capacityProviderArn",
    };
};
