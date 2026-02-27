const AwsMountPoint = @import("aws_mount_point.zig").AwsMountPoint;

/// Provides information about an Amazon ECS container.
pub const AwsEcsContainerDetails = struct {
    /// The image used for the container.
    image: ?[]const u8,

    /// The mount points for data volumes in your container.
    mount_points: ?[]const AwsMountPoint,

    /// The name of the container.
    name: ?[]const u8,

    /// When this parameter is true, the container is given elevated privileges on
    /// the host container instance
    /// (similar to the root user).
    privileged: ?bool,

    pub const json_field_names = .{
        .image = "Image",
        .mount_points = "MountPoints",
        .name = "Name",
        .privileged = "Privileged",
    };
};
