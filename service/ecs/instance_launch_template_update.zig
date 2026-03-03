const InstanceRequirementsRequest = @import("instance_requirements_request.zig").InstanceRequirementsRequest;
const ManagedInstancesMonitoringOptions = @import("managed_instances_monitoring_options.zig").ManagedInstancesMonitoringOptions;
const ManagedInstancesNetworkConfiguration = @import("managed_instances_network_configuration.zig").ManagedInstancesNetworkConfiguration;
const ManagedInstancesStorageConfiguration = @import("managed_instances_storage_configuration.zig").ManagedInstancesStorageConfiguration;

/// The updated launch template configuration for Amazon ECS Managed Instances.
/// You can
/// modify the instance profile, network configuration, storage settings, and
/// instance
/// requirements. Changes apply to new instances launched after the update.
///
/// For more information, see [Store instance launch
/// parameters in Amazon EC2 launch
/// templates](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-launch-templates.html) in the *Amazon EC2 User
/// Guide*.
pub const InstanceLaunchTemplateUpdate = struct {
    /// The updated Amazon Resource Name (ARN) of the instance profile. The new
    /// instance
    /// profile must have the necessary permissions for your tasks.
    ///
    /// For more information, see [Amazon
    /// ECS instance profile for Managed
    /// Instances](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/managed-instances-instance-profile.html) in the *Amazon ECS
    /// Developer Guide*.
    ec_2_instance_profile_arn: ?[]const u8 = null,

    /// The updated instance requirements for attribute-based instance type
    /// selection. Changes
    /// to instance requirements affect which instance types Amazon ECS selects for
    /// new
    /// instances.
    instance_requirements: ?InstanceRequirementsRequest = null,

    /// CloudWatch provides two categories of monitoring: basic monitoring and
    /// detailed
    /// monitoring. By default, your managed instance is configured for basic
    /// monitoring. You
    /// can optionally enable detailed monitoring to help you more quickly identify
    /// and act on
    /// operational issues. You can enable or turn off detailed monitoring at launch
    /// or when the
    /// managed instance is running or stopped. For more information, see [Detailed
    /// monitoring for Amazon ECS Managed
    /// Instances](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/detailed-monitoring-managed-instances.html) in the Amazon ECS
    /// Developer Guide.
    monitoring: ?ManagedInstancesMonitoringOptions = null,

    /// The updated network configuration for Amazon ECS Managed Instances. Changes
    /// to subnets
    /// and security groups affect new instances launched after the update.
    network_configuration: ?ManagedInstancesNetworkConfiguration = null,

    /// The updated storage configuration for Amazon ECS Managed Instances. Changes
    /// to storage
    /// settings apply to new instances launched after the update.
    storage_configuration: ?ManagedInstancesStorageConfiguration = null,

    pub const json_field_names = .{
        .ec_2_instance_profile_arn = "ec2InstanceProfileArn",
        .instance_requirements = "instanceRequirements",
        .monitoring = "monitoring",
        .network_configuration = "networkConfiguration",
        .storage_configuration = "storageConfiguration",
    };
};
