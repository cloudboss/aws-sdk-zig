/// The permissions configuration for a capacity provider. This specifies the
/// IAM role that AgentCore uses to manage the Amazon EC2 instances for the
/// capacity provider on your behalf.
pub const PermissionsConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the IAM role that AgentCore assumes to
    /// manage the capacity provider, including launching, tagging, and terminating
    /// instances and their network interfaces. We recommend scoping this role to
    /// the minimum permissions that your workloads require.
    capacity_provider_operator_role_arn: []const u8,

    pub const json_field_names = .{
        .capacity_provider_operator_role_arn = "capacityProviderOperatorRoleArn",
    };
};
