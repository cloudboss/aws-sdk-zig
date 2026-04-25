const AutoRepairConfiguration = @import("auto_repair_configuration.zig").AutoRepairConfiguration;
const InfrastructureOptimization = @import("infrastructure_optimization.zig").InfrastructureOptimization;
const InstanceLaunchTemplate = @import("instance_launch_template.zig").InstanceLaunchTemplate;
const PropagateMITags = @import("propagate_mi_tags.zig").PropagateMITags;

/// The configuration for a Amazon ECS Managed Instances provider. Amazon ECS
/// uses this configuration to automatically launch, manage, and terminate
/// Amazon EC2 instances on your behalf. Managed instances provide access to the
/// full range of Amazon EC2 instance types and features while offloading
/// infrastructure management to Amazon Web Services.
pub const ManagedInstancesProvider = struct {
    /// The auto repair configuration for the Amazon ECS Managed Instances capacity
    /// provider. Indicates whether Amazon ECS automatically replaces container
    /// instances that are detected as unhealthy.
    auto_repair_configuration: ?AutoRepairConfiguration = null,

    /// Defines how Amazon ECS Managed Instances optimizes the infrastastructure in
    /// your capacity provider. Configure it to turn on or off the infrastructure
    /// optimization in your capacity provider, and to control the idle or
    /// underutilized EC2 instances optimization delay.
    infrastructure_optimization: ?InfrastructureOptimization = null,

    /// The Amazon Resource Name (ARN) of the infrastructure role that Amazon ECS
    /// assumes to manage instances. This role must include permissions for Amazon
    /// EC2 instance lifecycle management, networking, and any additional Amazon Web
    /// Services services required for your workloads.
    ///
    /// For more information, see [Amazon ECS infrastructure IAM
    /// role](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/infrastructure_IAM_role.html) in the *Amazon ECS Developer Guide*.
    infrastructure_role_arn: ?[]const u8 = null,

    /// The launch template that defines how Amazon ECS launches Amazon ECS Managed
    /// Instances. This includes the instance profile for your tasks, network and
    /// storage configuration, and instance requirements that determine which Amazon
    /// EC2 instance types can be used.
    ///
    /// For more information, see [Store instance launch parameters in Amazon EC2
    /// launch
    /// templates](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-launch-templates.html) in the *Amazon EC2 User Guide*.
    instance_launch_template: ?InstanceLaunchTemplate = null,

    /// Determines whether tags from the capacity provider are automatically applied
    /// to Amazon ECS Managed Instances. This helps with cost allocation and
    /// resource management by ensuring consistent tagging across your
    /// infrastructure.
    propagate_tags: ?PropagateMITags = null,

    pub const json_field_names = .{
        .auto_repair_configuration = "autoRepairConfiguration",
        .infrastructure_optimization = "infrastructureOptimization",
        .infrastructure_role_arn = "infrastructureRoleArn",
        .instance_launch_template = "instanceLaunchTemplate",
        .propagate_tags = "propagateTags",
    };
};
