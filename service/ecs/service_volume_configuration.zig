const ServiceManagedEBSVolumeConfiguration = @import("service_managed_ebs_volume_configuration.zig").ServiceManagedEBSVolumeConfiguration;

/// The configuration for a volume specified in the task definition as a volume
/// that is configured at launch time. Currently, the only supported volume type
/// is an Amazon EBS volume.
pub const ServiceVolumeConfiguration = struct {
    /// The configuration for the Amazon EBS volume that Amazon ECS creates and
    /// manages on your behalf. These settings are used to create each Amazon EBS
    /// volume, with one volume created for each task in the service. The Amazon EBS
    /// volumes are visible in your account in the Amazon EC2 console once they are
    /// created.
    managed_ebs_volume: ?ServiceManagedEBSVolumeConfiguration = null,

    /// The name of the volume. This value must match the volume name from the
    /// `Volume` object in the task definition.
    name: []const u8,

    pub const json_field_names = .{
        .managed_ebs_volume = "managedEBSVolume",
        .name = "name",
    };
};
