const CapacityProviderScalingConfig = @import("capacity_provider_scaling_config.zig").CapacityProviderScalingConfig;
const InstanceRequirements = @import("instance_requirements.zig").InstanceRequirements;
const CapacityProviderPermissionsConfig = @import("capacity_provider_permissions_config.zig").CapacityProviderPermissionsConfig;
const CapacityProviderState = @import("capacity_provider_state.zig").CapacityProviderState;
const CapacityProviderVpcConfig = @import("capacity_provider_vpc_config.zig").CapacityProviderVpcConfig;

/// A capacity provider manages compute resources for Lambda functions.
pub const CapacityProvider = struct {
    /// The Amazon Resource Name (ARN) of the capacity provider.
    capacity_provider_arn: []const u8,

    /// The scaling configuration for the capacity provider.
    capacity_provider_scaling_config: ?CapacityProviderScalingConfig,

    /// The instance requirements for compute resources managed by the capacity
    /// provider.
    instance_requirements: ?InstanceRequirements,

    /// The ARN of the KMS key used to encrypt the capacity provider's resources.
    kms_key_arn: ?[]const u8,

    /// The date and time when the capacity provider was last modified.
    last_modified: ?[]const u8,

    /// The permissions configuration for the capacity provider.
    permissions_config: CapacityProviderPermissionsConfig,

    /// The current state of the capacity provider.
    state: CapacityProviderState,

    /// The VPC configuration for the capacity provider.
    vpc_config: CapacityProviderVpcConfig,

    pub const json_field_names = .{
        .capacity_provider_arn = "CapacityProviderArn",
        .capacity_provider_scaling_config = "CapacityProviderScalingConfig",
        .instance_requirements = "InstanceRequirements",
        .kms_key_arn = "KmsKeyArn",
        .last_modified = "LastModified",
        .permissions_config = "PermissionsConfig",
        .state = "State",
        .vpc_config = "VpcConfig",
    };
};
