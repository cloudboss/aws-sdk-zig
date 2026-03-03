const AwsEcsTaskVolumeHostDetails = @import("aws_ecs_task_volume_host_details.zig").AwsEcsTaskVolumeHostDetails;

/// Provides information about a data volume that's used in a task definition.
pub const AwsEcsTaskVolumeDetails = struct {
    /// This parameter is specified when you use bind mount host volumes. The
    /// contents of the `host` parameter
    /// determine whether your bind mount host volume persists on the host container
    /// instance and where it's stored.
    host: ?AwsEcsTaskVolumeHostDetails = null,

    /// The name of the volume. Up to 255 letters (uppercase and lowercase),
    /// numbers, underscores, and
    /// hyphens are allowed. This name is referenced in the `sourceVolume` parameter
    /// of container definition `mountPoints`.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .host = "Host",
        .name = "Name",
    };
};
