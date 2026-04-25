const AutoRepairConfiguration = @import("auto_repair_configuration.zig").AutoRepairConfiguration;
const InfrastructureOptimization = @import("infrastructure_optimization.zig").InfrastructureOptimization;
const InstanceLaunchTemplateUpdate = @import("instance_launch_template_update.zig").InstanceLaunchTemplateUpdate;
const PropagateMITags = @import("propagate_mi_tags.zig").PropagateMITags;

/// The updated configuration for a Amazon ECS Managed Instances provider. You
/// can modify the infrastructure role, instance launch template, and tag
/// propagation settings. Changes apply to new instances launched after the
/// update.
pub const UpdateManagedInstancesProviderConfiguration = struct {
    /// The updated auto repair configuration for the Amazon ECS Managed Instances
    /// capacity provider.
    auto_repair_configuration: ?AutoRepairConfiguration = null,

    /// The updated infrastructure optimization configuration. Changes to this
    /// setting affect how Amazon ECS optimizes instances going forward.
    infrastructure_optimization: ?InfrastructureOptimization = null,

    /// The updated Amazon Resource Name (ARN) of the infrastructure role. The new
    /// role must have the necessary permissions to manage instances and access
    /// required Amazon Web Services services.
    ///
    /// For more information, see [Amazon ECS infrastructure IAM
    /// role](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/infrastructure_IAM_role.html) in the *Amazon ECS Developer Guide*.
    infrastructure_role_arn: []const u8,

    /// The updated launch template configuration. Changes to the launch template
    /// affect new instances launched after the update, while existing instances
    /// continue to use their original configuration.
    instance_launch_template: InstanceLaunchTemplateUpdate,

    /// The updated tag propagation setting. When changed, this affects only new
    /// instances launched after the update.
    propagate_tags: ?PropagateMITags = null,

    pub const json_field_names = .{
        .auto_repair_configuration = "autoRepairConfiguration",
        .infrastructure_optimization = "infrastructureOptimization",
        .infrastructure_role_arn = "infrastructureRoleArn",
        .instance_launch_template = "instanceLaunchTemplate",
        .propagate_tags = "propagateTags",
    };
};
