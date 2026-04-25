const CapacityOptionType = @import("capacity_option_type.zig").CapacityOptionType;
const CapacityReservationRequest = @import("capacity_reservation_request.zig").CapacityReservationRequest;
const InstanceRequirementsRequest = @import("instance_requirements_request.zig").InstanceRequirementsRequest;
const ManagedInstancesLocalStorageConfiguration = @import("managed_instances_local_storage_configuration.zig").ManagedInstancesLocalStorageConfiguration;
const ManagedInstancesMonitoringOptions = @import("managed_instances_monitoring_options.zig").ManagedInstancesMonitoringOptions;
const ManagedInstancesNetworkConfiguration = @import("managed_instances_network_configuration.zig").ManagedInstancesNetworkConfiguration;
const ManagedInstancesStorageConfiguration = @import("managed_instances_storage_configuration.zig").ManagedInstancesStorageConfiguration;

/// The launch template configuration for Amazon ECS Managed Instances. This
/// defines how Amazon ECS launches Amazon EC2 instances, including the instance
/// profile for your tasks, network and storage configuration, capacity options,
/// and instance requirements for flexible instance type selection.
pub const InstanceLaunchTemplate = struct {
    /// The capacity option type. This determines whether Amazon ECS launches
    /// On-Demand, Spot or Capacity Reservation Instances for your managed instance
    /// capacity provider.
    ///
    /// Valid values are:
    ///
    /// * `ON_DEMAND` - Launches standard On-Demand Instances. On-Demand Instances
    ///   provide predictable pricing and availability.
    /// * `SPOT` - Launches Spot Instances that use spare Amazon EC2 capacity at
    ///   reduced cost. Spot Instances can be interrupted by Amazon EC2 with a
    ///   two-minute notification when the capacity is needed back.
    /// * `RESERVED` - Launches Instances using Amazon EC2 Capacity Reservations.
    ///   Capacity Reservations allow you to reserve compute capacity for Amazon EC2
    ///   instances in a specific Availability Zone.
    ///
    /// The default is On-Demand
    ///
    /// For more information about Amazon EC2 capacity options, see [Instance
    /// purchasing
    /// options](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-purchasing-options.html) in the *Amazon EC2 User Guide*.
    capacity_option_type: ?CapacityOptionType = null,

    /// Capacity reservation specifications. You can specify:
    ///
    /// * Capacity reservation preference
    /// * Reservation resource group to be used for targeted capacity reservations
    ///
    /// Amazon ECS will launch instances according to the specified criteria.
    capacity_reservations: ?CapacityReservationRequest = null,

    /// The Amazon Resource Name (ARN) of the instance profile that Amazon ECS
    /// applies to Amazon ECS Managed Instances. This instance profile must include
    /// the necessary permissions for your tasks to access Amazon Web Services
    /// services and resources.
    ///
    /// For more information, see [Amazon ECS instance profile for Managed
    /// Instances](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/managed-instances-instance-profile.html) in the *Amazon ECS Developer Guide*.
    ec_2_instance_profile_arn: []const u8,

    /// Determines whether to enable FIPS 140-2 validated cryptographic modules on
    /// EC2 instances launched by the capacity provider. If `true`, instances use
    /// FIPS-compliant cryptographic algorithms and modules for enhanced security
    /// compliance. If `false`, instances use standard cryptographic
    /// implementations.
    ///
    /// If not specified, instances are launched with FIPS enabled in Amazon Web
    /// Services GovCloud (US) regions and FIPS disabled in other regions.
    fips_enabled: ?bool = null,

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

    /// The instance requirements. You can specify:
    ///
    /// * The instance types
    /// * Instance requirements such as vCPU count, memory, network performance, and
    ///   accelerator specifications
    ///
    /// Amazon ECS automatically selects the instances that match the specified
    /// criteria.
    instance_requirements: ?InstanceRequirementsRequest = null,

    /// The local storage configuration for Amazon ECS Managed Instances. This
    /// defines how ECS uses instance store volumes available on the container
    /// instance.
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

    /// The network configuration for Amazon ECS Managed Instances. This specifies
    /// the subnets and security groups that instances use for network connectivity.
    network_configuration: ManagedInstancesNetworkConfiguration,

    /// The storage configuration for Amazon ECS Managed Instances. This defines the
    /// data volume properties for the instances.
    storage_configuration: ?ManagedInstancesStorageConfiguration = null,

    pub const json_field_names = .{
        .capacity_option_type = "capacityOptionType",
        .capacity_reservations = "capacityReservations",
        .ec_2_instance_profile_arn = "ec2InstanceProfileArn",
        .fips_enabled = "fipsEnabled",
        .instance_metadata_tags_propagation = "instanceMetadataTagsPropagation",
        .instance_requirements = "instanceRequirements",
        .local_storage_configuration = "localStorageConfiguration",
        .monitoring = "monitoring",
        .network_configuration = "networkConfiguration",
        .storage_configuration = "storageConfiguration",
    };
};
