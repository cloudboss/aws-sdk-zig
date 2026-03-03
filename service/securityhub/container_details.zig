const VolumeMount = @import("volume_mount.zig").VolumeMount;

/// Container details related to a finding.
pub const ContainerDetails = struct {
    /// The runtime of the container.
    container_runtime: ?[]const u8 = null,

    /// The identifier of the container image related to a finding.
    image_id: ?[]const u8 = null,

    /// The name of the container image related to a finding.
    image_name: ?[]const u8 = null,

    /// Indicates when the container started.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    launched_at: ?[]const u8 = null,

    /// The name of the container related to a finding.
    name: ?[]const u8 = null,

    /// When this parameter is `true`, the container is given elevated privileges on
    /// the host
    /// container instance (similar to the root user).
    privileged: ?bool = null,

    /// Provides information about the mounting of a volume in a container.
    volume_mounts: ?[]const VolumeMount = null,

    pub const json_field_names = .{
        .container_runtime = "ContainerRuntime",
        .image_id = "ImageId",
        .image_name = "ImageName",
        .launched_at = "LaunchedAt",
        .name = "Name",
        .privileged = "Privileged",
        .volume_mounts = "VolumeMounts",
    };
};
