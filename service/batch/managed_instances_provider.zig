const InfrastructureOptimization = @import("infrastructure_optimization.zig").InfrastructureOptimization;
const InstanceLaunchTemplate = @import("instance_launch_template.zig").InstanceLaunchTemplate;

/// The configuration for an Amazon ECS Managed Instances capacity provider.
/// This object is required
/// when creating a compute environment with `computeResources.type` set to
/// `ECS_MANAGED_INSTANCES`.
pub const ManagedInstancesProvider = struct {
    /// The infrastructure optimization configuration for the capacity provider.
    /// Specifies the
    /// idle-instance scale-in behavior.
    infrastructure_optimization: ?InfrastructureOptimization = null,

    /// The Amazon Resource Name (ARN) of the IAM role that Amazon ECS assumes to
    /// manage Amazon EC2 instances on your behalf.
    /// This role must have a trust policy for `ecs.amazonaws.com`. You must have
    /// the
    /// `iam:PassRole` permission for this role with the condition
    /// `iam:PassedToService: ecs.amazonaws.com`.
    infrastructure_role_arn: []const u8,

    /// The instance launch configuration for the Amazon ECS Managed Instances
    /// capacity provider.
    /// Contains networking, instance profile, instance requirements, capacity type,
    /// storage, and
    /// monitoring configuration.
    instance_launch_template: InstanceLaunchTemplate,

    /// Specifies whether tags on the capacity provider are propagated to the Amazon
    /// EC2 instances it
    /// launches. Valid values:
    ///
    /// * `CAPACITY_PROVIDER` — Propagates tags to instances.
    ///
    /// * `NONE` (default) — Does not propagate tags to instances.
    propagate_tags: ?[]const u8 = null,

    pub const json_field_names = .{
        .infrastructure_optimization = "infrastructureOptimization",
        .infrastructure_role_arn = "infrastructureRoleArn",
        .instance_launch_template = "instanceLaunchTemplate",
        .propagate_tags = "propagateTags",
    };
};
