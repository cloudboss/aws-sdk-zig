/// The volume mounts for a container for an Amazon EKS job. For more
/// information about volumes and
/// volume mounts in Kubernetes, see
/// [Volumes](https://kubernetes.io/docs/concepts/storage/volumes/) in the
/// *Kubernetes documentation*.
pub const EksContainerVolumeMount = struct {
    /// The path on the container where the volume is mounted.
    mount_path: ?[]const u8 = null,

    /// The name the volume mount. This must match the name of one of the volumes in
    /// the
    /// pod.
    name: ?[]const u8 = null,

    /// If this value is `true`, the container has read-only access to the volume.
    /// Otherwise, the container can write to the volume. The default value is
    /// `false`.
    read_only: ?bool = null,

    /// A sub-path inside the referenced volume instead of its root.
    sub_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .mount_path = "mountPath",
        .name = "name",
        .read_only = "readOnly",
        .sub_path = "subPath",
    };
};
