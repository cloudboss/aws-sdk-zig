/// Specifies the configuration of a Kubernetes `hostPath` volume. A `hostPath`
/// volume mounts an existing file or directory from the host node's filesystem
/// into your pod. For
/// more information, see
/// [hostPath](https://kubernetes.io/docs/concepts/storage/volumes/#hostpath) in
/// the *Kubernetes documentation*.
pub const EksHostPath = struct {
    /// The path of the file or directory on the host to mount into containers on
    /// the pod.
    path: ?[]const u8 = null,

    pub const json_field_names = .{
        .path = "path",
    };
};
