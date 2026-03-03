/// Details for a Docker volume mount point that's used in a job's container
/// properties. This
/// parameter maps to `Volumes` in the [Create a
/// container](https://docs.docker.com/engine/api/v1.43/#tag/Container/operation/ContainerCreate) section of the *Docker Remote API* and the
/// `--volume` option to docker run.
pub const MountPoint = struct {
    /// The path on the container where the host volume is mounted.
    container_path: ?[]const u8 = null,

    /// If this value is `true`, the container has read-only access to the volume.
    /// Otherwise, the container can write to the volume. The default value is
    /// `false`.
    read_only: ?bool = null,

    /// The name of the volume to mount.
    source_volume: ?[]const u8 = null,

    pub const json_field_names = .{
        .container_path = "containerPath",
        .read_only = "readOnly",
        .source_volume = "sourceVolume",
    };
};
