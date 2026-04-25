const CapacityReservationRequest = @import("capacity_reservation_request.zig").CapacityReservationRequest;
const InstanceRequirementsRequest = @import("instance_requirements_request.zig").InstanceRequirementsRequest;
const ManagedInstancesLocalStorageConfiguration = @import("managed_instances_local_storage_configuration.zig").ManagedInstancesLocalStorageConfiguration;
const ManagedInstancesMonitoringOptions = @import("managed_instances_monitoring_options.zig").ManagedInstancesMonitoringOptions;
const ManagedInstancesNetworkConfiguration = @import("managed_instances_network_configuration.zig").ManagedInstancesNetworkConfiguration;
const ManagedInstancesStorageConfiguration = @import("managed_instances_storage_configuration.zig").ManagedInstancesStorageConfiguration;

/// The updated launch template configuration for Amazon ECS Managed Instances.
/// You can modify the instance profile, network configuration, storage
/// settings, and instance requirements. Changes apply to new instances launched
/// after the update.
///
/// For more information, see [Store instance launch parameters in Amazon EC2
/// launch
/// templates](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-launch-templates.html) in the *Amazon EC2 User Guide*.
pub const InstanceLaunchTemplateUpdate = struct {
    /// The updated capacity reservations specifications for Amazon ECS Managed
    /// Instances. Changes to capacity reservations settings apply to new instances
    /// launched after the update.
    capacity_reservations: ?CapacityReservationRequest = null,

    /// The updated Amazon Resource Name (ARN) of the instance profile. The new
    /// instance profile must have the necessary permissions for your tasks.
    ///
    /// For more information, see [Amazon ECS instance profile for Managed
    /// Instances](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/managed-instances-instance-profile.html) in the *Amazon ECS Developer Guide*.
    ec_2_instance_profile_arn: ?[]const u8 = null,

    /// Determines whether tags are propagated to the instance metadata service
    /// (IMDS) for Amazon EC2 instances launched by the Managed Instances capacity
    /// provider. When enabled, all tags associated with the instance are available
    /// through the instance metadata service. When disabled, tags are not
    /// propagated to IMDS.
    ///
    /// Disable this setting if your tags contain characters that are not compatible
    /// with IMDS, such as `/`. IMDS requires tag keys to match the pattern
    /// `[0-9a-zA-Z\-_+=,.@:]{1,255}`.
    ///
    /// The default value is `true`.
    ///
    /// For more information, see [Work with instance tags in instance
    /// metadata](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html#work-with-tags-in-IMDS) in the *Amazon EC2 User Guide*.
    instance_metadata_tags_propagation: ?bool = null,

    /// The updated instance requirements for attribute-based instance type
    /// selection. Changes to instance requirements affect which instance types
    /// Amazon ECS selects for new instances.
    instance_requirements: ?InstanceRequirementsRequest = null,

    /// The updated local storage configuration for Amazon ECS Managed Instances.
    /// Changes to local storage settings apply to new instances launched after the
    /// update.
    local_storage_configuration: ?ManagedInstancesLocalStorageConfiguration = null,

    /// CloudWatch provides two categories of monitoring: basic monitoring and
    /// detailed monitoring. By default, your managed instance is configured for
    /// basic monitoring. You can optionally enable detailed monitoring to help you
    /// more quickly identify and act on operational issues. You can enable or turn
    /// off detailed monitoring at launch or when the managed instance is running or
    /// stopped. For more information, see [Detailed monitoring for Amazon ECS
    /// Managed
    /// Instances](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/detailed-monitoring-managed-instances.html) in the Amazon ECS Developer Guide.
    monitoring: ?ManagedInstancesMonitoringOptions = null,

    /// The updated network configuration for Amazon ECS Managed Instances. Changes
    /// to subnets and security groups affect new instances launched after the
    /// update.
    network_configuration: ?ManagedInstancesNetworkConfiguration = null,

    /// The updated storage configuration for Amazon ECS Managed Instances. Changes
    /// to storage settings apply to new instances launched after the update.
    storage_configuration: ?ManagedInstancesStorageConfiguration = null,

    pub const json_field_names = .{
        .capacity_reservations = "capacityReservations",
        .ec_2_instance_profile_arn = "ec2InstanceProfileArn",
        .instance_metadata_tags_propagation = "instanceMetadataTagsPropagation",
        .instance_requirements = "instanceRequirements",
        .local_storage_configuration = "localStorageConfiguration",
        .monitoring = "monitoring",
        .network_configuration = "networkConfiguration",
        .storage_configuration = "storageConfiguration",
    };
};
