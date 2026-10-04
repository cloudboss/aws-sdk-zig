const CapacityReservationRequest = @import("capacity_reservation_request.zig").CapacityReservationRequest;
const InstanceRequirementsRequest = @import("instance_requirements_request.zig").InstanceRequirementsRequest;
const ManagedInstancesLocalStorageConfiguration = @import("managed_instances_local_storage_configuration.zig").ManagedInstancesLocalStorageConfiguration;
const ManagedInstancesNetworkConfiguration = @import("managed_instances_network_configuration.zig").ManagedInstancesNetworkConfiguration;
const ManagedInstancesStorageConfiguration = @import("managed_instances_storage_configuration.zig").ManagedInstancesStorageConfiguration;

/// The instance launch configuration for an Amazon ECS Managed Instances
/// capacity provider.
/// Specifies the instance profile, networking, instance selection constraints,
/// capacity pricing
/// model, storage, and monitoring settings.
pub const InstanceLaunchTemplate = struct {
    /// The capacity pricing model for the managed instances. Valid values:
    ///
    /// * `ON_DEMAND` (default) — On-Demand pricing.
    ///
    /// * `SPOT` — Spot Instances, which can provide significant cost savings
    /// for fault-tolerant workloads.
    capacity_option_type: ?[]const u8 = null,

    /// The capacity reservation configuration for the managed instances. Use this
    /// to target
    /// On-Demand Capacity Reservations or Reserved Instances for predictable
    /// capacity and cost
    /// optimization.
    capacity_reservations: ?CapacityReservationRequest = null,

    /// The Amazon Resource Name (ARN) of the Amazon EC2 instance profile for the
    /// managed instances. The instance profile
    /// must use the `AmazonECSInstanceRolePolicyForManagedInstances` managed policy
    /// with a
    /// trust policy for `ec2.amazonaws.com`.
    ec_2_instance_profile_arn: []const u8,

    /// Specifies whether FIPS 140-2 validated cryptographic modules are enabled on
    /// the managed
    /// instances. Not available in all Regions.
    fips_enabled: ?bool = null,

    /// Specifies whether instance tags are accessible from the instance metadata
    /// service (IMDS).
    /// If not specified, instance tags are not accessible from IMDS.
    instance_metadata_tags_propagation: ?bool = null,

    /// The instance type requirements for the capacity provider. Use this to
    /// constrain which Amazon EC2
    /// instance types Amazon ECS can launch. If not specified, all available
    /// instance types are
    /// eligible.
    instance_requirements: ?InstanceRequirementsRequest = null,

    /// The local storage configuration for the managed instances. If not specified,
    /// instance store
    /// volumes are not available to containers.
    local_storage_configuration: ?ManagedInstancesLocalStorageConfiguration = null,

    /// The level of CloudWatch monitoring for the managed instances. Valid values
    /// are
    /// `BASIC` and `DETAILED`.
    monitoring: ?[]const u8 = null,

    /// The network configuration for the managed instances. Specifies the VPC
    /// subnets and security
    /// groups where instances are launched.
    network_configuration: ManagedInstancesNetworkConfiguration,

    /// The storage configuration for the managed instances. Configures the root EBS
    /// volume size.
    /// If not specified, the service uses the default EBS volume size for the
    /// instance type.
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
