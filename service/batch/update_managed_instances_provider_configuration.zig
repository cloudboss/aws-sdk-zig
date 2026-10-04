const InfrastructureOptimization = @import("infrastructure_optimization.zig").InfrastructureOptimization;
const InstanceLaunchTemplateUpdate = @import("instance_launch_template_update.zig").InstanceLaunchTemplateUpdate;

/// The configuration for updating an Amazon ECS Managed Instances capacity
/// provider. Used in
/// `UpdateComputeEnvironment` requests. The `capacityOptionType` and
/// `fipsEnabled` fields cannot be changed on update.
pub const UpdateManagedInstancesProviderConfiguration = struct {
    /// The updated infrastructure optimization configuration.
    infrastructure_optimization: ?InfrastructureOptimization = null,

    /// The updated Amazon Resource Name (ARN) of the IAM role that Amazon ECS
    /// assumes to manage Amazon EC2 instances on
    /// your behalf.
    infrastructure_role_arn: ?[]const u8 = null,

    /// The updated instance launch configuration for the Amazon ECS Managed
    /// Instances capacity
    /// provider.
    instance_launch_template: ?InstanceLaunchTemplateUpdate = null,

    /// Specifies whether tags on the capacity provider are propagated to the Amazon
    /// EC2 instances it
    /// launches. Valid values:
    ///
    /// * `CAPACITY_PROVIDER` — Propagates tags to instances.
    ///
    /// * `NONE` — Does not propagate tags to instances.
    propagate_tags: ?[]const u8 = null,

    pub const json_field_names = .{
        .infrastructure_optimization = "infrastructureOptimization",
        .infrastructure_role_arn = "infrastructureRoleArn",
        .instance_launch_template = "instanceLaunchTemplate",
        .propagate_tags = "propagateTags",
    };
};
