/// A `persistentVolumeClaim` volume is used to mount a
/// [PersistentVolume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
/// into a Pod. PersistentVolumeClaims are a way for users to "claim" durable
/// storage without knowing
/// the details of the particular cloud environment. See the information about
/// [PersistentVolumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
/// in the *Kubernetes documentation*.
pub const EksPersistentVolumeClaim = struct {
    /// The name of the `persistentVolumeClaim` bounded to a `persistentVolume`.
    /// For more information, see [
    /// Persistent Volume
    /// Claims](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims) in the *Kubernetes documentation*.
    claim_name: []const u8,

    /// An optional boolean value indicating if the mount is read only. Default is
    /// false. For more
    /// information, see [
    /// Read Only
    /// Mounts](https://kubernetes.io/docs/concepts/storage/volumes/#read-only-mounts) in the *Kubernetes documentation*.
    read_only: ?bool,

    pub const json_field_names = .{
        .claim_name = "claimName",
        .read_only = "readOnly",
    };
};
