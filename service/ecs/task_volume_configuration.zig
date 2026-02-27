const TaskManagedEBSVolumeConfiguration = @import("task_managed_ebs_volume_configuration.zig").TaskManagedEBSVolumeConfiguration;

/// Configuration settings for the task volume that was `configuredAtLaunch`
/// that weren't set during `RegisterTaskDef`.
pub const TaskVolumeConfiguration = struct {
    /// The configuration for the Amazon EBS volume that Amazon ECS creates and
    /// manages on
    /// your behalf. These settings are used to create each Amazon EBS volume, with
    /// one volume
    /// created for each task. The Amazon EBS volumes are visible in your account in
    /// the Amazon
    /// EC2 console once they are created.
    managed_ebs_volume: ?TaskManagedEBSVolumeConfiguration,

    /// The name of the volume. This value must match the volume name from the
    /// `Volume` object in the task definition.
    name: []const u8,

    pub const json_field_names = .{
        .managed_ebs_volume = "managedEBSVolume",
        .name = "name",
    };
};
