const EksEmptyDir = @import("eks_empty_dir.zig").EksEmptyDir;
const EksHostPath = @import("eks_host_path.zig").EksHostPath;
const EksPersistentVolumeClaim = @import("eks_persistent_volume_claim.zig").EksPersistentVolumeClaim;
const EksSecret = @import("eks_secret.zig").EksSecret;

/// Specifies an Amazon EKS volume for a job definition.
pub const EksVolume = struct {
    /// Specifies the configuration of a Kubernetes `emptyDir` volume. For more
    /// information,
    /// see
    /// [emptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir)
    /// in the *Kubernetes documentation*.
    empty_dir: ?EksEmptyDir = null,

    /// Specifies the configuration of a Kubernetes `hostPath` volume. For more
    /// information,
    /// see
    /// [hostPath](https://kubernetes.io/docs/concepts/storage/volumes/#hostpath)
    /// in the *Kubernetes documentation*.
    host_path: ?EksHostPath = null,

    /// The name of the volume. The name must be allowed as a DNS subdomain name.
    /// For more
    /// information, see [DNS subdomain
    /// names](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#dns-subdomain-names) in the *Kubernetes documentation*.
    name: []const u8,

    /// Specifies the configuration of a Kubernetes `persistentVolumeClaim` bounded
    /// to a
    /// `persistentVolume`. For more information, see [
    /// Persistent Volume
    /// Claims](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims) in the *Kubernetes documentation*.
    persistent_volume_claim: ?EksPersistentVolumeClaim = null,

    /// Specifies the configuration of a Kubernetes `secret` volume. For more
    /// information, see
    /// [secret](https://kubernetes.io/docs/concepts/storage/volumes/#secret) in the
    /// *Kubernetes documentation*.
    secret: ?EksSecret = null,

    pub const json_field_names = .{
        .empty_dir = "emptyDir",
        .host_path = "hostPath",
        .name = "name",
        .persistent_volume_claim = "persistentVolumeClaim",
        .secret = "secret",
    };
};
