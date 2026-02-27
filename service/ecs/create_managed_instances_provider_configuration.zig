const InfrastructureOptimization = @import("infrastructure_optimization.zig").InfrastructureOptimization;
const InstanceLaunchTemplate = @import("instance_launch_template.zig").InstanceLaunchTemplate;
const PropagateMITags = @import("propagate_mi_tags.zig").PropagateMITags;

/// The configuration for creating a Amazon ECS Managed Instances provider. This
/// specifies
/// how Amazon ECS should manage Amazon EC2 instances, including the
/// infrastructure role,
/// instance launch template, and whether to propagate tags from the capacity
/// provider to
/// the instances.
pub const CreateManagedInstancesProviderConfiguration = struct {
    /// Defines how Amazon ECS Managed Instances optimizes the infrastastructure in
    /// your capacity provider.
    /// Provides control over the delay between when EC2 instances become idle or
    /// underutilized and when Amazon ECS optimizes them.
    infrastructure_optimization: ?InfrastructureOptimization,

    /// The Amazon Resource Name (ARN) of the infrastructure role that Amazon ECS
    /// uses to
    /// manage instances on your behalf. This role must have permissions to launch,
    /// terminate,
    /// and manage Amazon EC2 instances, as well as access to other Amazon Web
    /// Services services
    /// required for Amazon ECS Managed Instances functionality.
    ///
    /// For more information, see [Amazon ECS
    /// infrastructure IAM
    /// role](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/infrastructure_IAM_role.html) in the *Amazon ECS Developer
    /// Guide*.
    infrastructure_role_arn: []const u8,

    /// The launch template configuration that specifies how Amazon ECS should
    /// launch Amazon
    /// EC2 instances. This includes the instance profile, network configuration,
    /// storage
    /// settings, and instance requirements for attribute-based instance type
    /// selection.
    ///
    /// For more information, see [Store instance launch
    /// parameters in Amazon EC2 launch
    /// templates](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-launch-templates.html) in the *Amazon EC2 User
    /// Guide*.
    instance_launch_template: InstanceLaunchTemplate,

    /// Specifies whether to propagate tags from the capacity provider to the Amazon
    /// ECS
    /// Managed Instances. When enabled, tags applied to the capacity provider are
    /// automatically
    /// applied to all instances launched by this provider.
    propagate_tags: ?PropagateMITags,

    pub const json_field_names = .{
        .infrastructure_optimization = "infrastructureOptimization",
        .infrastructure_role_arn = "infrastructureRoleArn",
        .instance_launch_template = "instanceLaunchTemplate",
        .propagate_tags = "propagateTags",
    };
};
