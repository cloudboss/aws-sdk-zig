const aws = @import("aws");

const CapacityReservationSpecification = @import("capacity_reservation_specification.zig").CapacityReservationSpecification;
const EphemeralBlockDeviceMapping = @import("ephemeral_block_device_mapping.zig").EphemeralBlockDeviceMapping;
const InstanceRequirements = @import("instance_requirements.zig").InstanceRequirements;
const LicenseSpecification = @import("license_specification.zig").LicenseSpecification;
const Monitoring = @import("monitoring.zig").Monitoring;
const OperatingSystem = @import("operating_system.zig").OperatingSystem;

/// The parameters for launching Amazon EC2 instances in a capacity provider.
pub const LaunchParameters = struct {
    /// The Capacity Reservation targeting option for the instances.
    capacity_reservation_specification: ?CapacityReservationSpecification = null,

    /// The block device mappings for instance store (ephemeral) volumes. You can
    /// specify up to five mappings.
    ephemeral_volumes: ?[]const EphemeralBlockDeviceMapping = null,

    /// The Amazon Resource Name (ARN) of the IAM instance profile to associate with
    /// launched instances. If provided, this overrides the default instance
    /// profile.
    instance_profile_arn: ?[]const u8 = null,

    /// The requirements that determine which instance types can be launched.
    instance_requirements: InstanceRequirements,

    /// The license configurations to associate with the instances. You can specify
    /// up to five configurations.
    license_specifications: ?[]const LicenseSpecification = null,

    /// The monitoring level for the instances.
    monitoring: ?Monitoring = null,

    /// The operating system and CPU architecture for the instances.
    operating_system: OperatingSystem,

    /// The tags to propagate to all Amazon EC2 resources (instances, volumes, and
    /// network interfaces) that the capacity provider creates.
    propagated_tags: ?[]const aws.map.StringMapEntry = null,

    /// The name of the SSH key pair to configure on the instances for SSH
    /// connectivity.
    ssh_key_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .capacity_reservation_specification = "capacityReservationSpecification",
        .ephemeral_volumes = "ephemeralVolumes",
        .instance_profile_arn = "instanceProfileArn",
        .instance_requirements = "instanceRequirements",
        .license_specifications = "licenseSpecifications",
        .monitoring = "monitoring",
        .operating_system = "operatingSystem",
        .propagated_tags = "propagatedTags",
        .ssh_key_name = "sshKeyName",
    };
};
