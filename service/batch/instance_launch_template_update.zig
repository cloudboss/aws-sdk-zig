const CapacityReservationRequest = @import("capacity_reservation_request.zig").CapacityReservationRequest;
const InstanceRequirementsRequest = @import("instance_requirements_request.zig").InstanceRequirementsRequest;
const ManagedInstancesLocalStorageConfiguration = @import("managed_instances_local_storage_configuration.zig").ManagedInstancesLocalStorageConfiguration;
const ManagedInstancesNetworkConfiguration = @import("managed_instances_network_configuration.zig").ManagedInstancesNetworkConfiguration;
const ManagedInstancesStorageConfiguration = @import("managed_instances_storage_configuration.zig").ManagedInstancesStorageConfiguration;

/// The instance launch configuration for updating an Amazon ECS Managed
/// Instances capacity
/// provider. You cannot change `capacityOptionType` or `fipsEnabled` after
/// the compute environment is created.
pub const InstanceLaunchTemplateUpdate = struct {
    /// The updated capacity reservation configuration.
    capacity_reservations: ?CapacityReservationRequest = null,

    /// The updated Amazon Resource Name (ARN) of the Amazon EC2 instance profile
    /// for the managed instances.
    ec_2_instance_profile_arn: ?[]const u8 = null,

    /// Specifies whether instance tags are accessible from the instance metadata
    /// service
    /// (IMDS).
    instance_metadata_tags_propagation: ?bool = null,

    /// The updated instance type requirements for the capacity provider.
    instance_requirements: ?InstanceRequirementsRequest = null,

    /// The updated local storage configuration.
    local_storage_configuration: ?ManagedInstancesLocalStorageConfiguration = null,

    /// The updated monitoring level. Valid values are `BASIC` and
    /// `DETAILED`.
    monitoring: ?[]const u8 = null,

    /// The updated network configuration for the managed instances.
    network_configuration: ?ManagedInstancesNetworkConfiguration = null,

    /// The updated storage configuration for the managed instances.
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
