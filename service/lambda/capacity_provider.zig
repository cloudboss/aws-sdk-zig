const CapacityProviderScalingConfig = @import("capacity_provider_scaling_config.zig").CapacityProviderScalingConfig;
const InstanceRequirements = @import("instance_requirements.zig").InstanceRequirements;
const CapacityProviderPermissionsConfig = @import("capacity_provider_permissions_config.zig").CapacityProviderPermissionsConfig;
const PropagateTags = @import("propagate_tags.zig").PropagateTags;
const CapacityProviderState = @import("capacity_provider_state.zig").CapacityProviderState;
const CapacityProviderTelemetryConfig = @import("capacity_provider_telemetry_config.zig").CapacityProviderTelemetryConfig;
const CapacityProviderVpcConfig = @import("capacity_provider_vpc_config.zig").CapacityProviderVpcConfig;

/// A capacity provider manages compute resources for Lambda functions.
pub const CapacityProvider = struct {
    /// The Amazon Resource Name (ARN) of the capacity provider.
    capacity_provider_arn: []const u8,

    /// The scaling configuration for the capacity provider.
    capacity_provider_scaling_config: ?CapacityProviderScalingConfig = null,

    /// The instance requirements for compute resources managed by the capacity
    /// provider.
    instance_requirements: ?InstanceRequirements = null,

    /// The ARN of the KMS key used to encrypt the capacity provider's resources.
    kms_key_arn: ?[]const u8 = null,

    /// The date and time when the capacity provider was last modified.
    last_modified: ?[]const u8 = null,

    /// The permissions configuration for the capacity provider.
    permissions_config: CapacityProviderPermissionsConfig,

    propagate_tags: ?PropagateTags = null,

    /// The current state of the capacity provider.
    state: CapacityProviderState,

    /// The telemetry configuration for the capacity provider, including logging
    /// settings.
    telemetry_config: ?CapacityProviderTelemetryConfig = null,

    /// The VPC configuration for the capacity provider.
    vpc_config: CapacityProviderVpcConfig,

    pub const json_field_names = .{
        .capacity_provider_arn = "CapacityProviderArn",
        .capacity_provider_scaling_config = "CapacityProviderScalingConfig",
        .instance_requirements = "InstanceRequirements",
        .kms_key_arn = "KmsKeyArn",
        .last_modified = "LastModified",
        .permissions_config = "PermissionsConfig",
        .propagate_tags = "PropagateTags",
        .state = "State",
        .telemetry_config = "TelemetryConfig",
        .vpc_config = "VpcConfig",
    };
};
