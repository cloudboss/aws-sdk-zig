/// An object containing the name of the Kubernetes service account inside the
/// cluster to
/// associate the IAM credentials with.
pub const Subject = struct {
    /// The name of the Kubernetes namespace inside the cluster to create the
    /// association in. The
    /// service account and the pods that use the service account must be in this
    /// namespace.
    namespace: []const u8,

    /// The name of the Kubernetes service account inside the cluster to associate
    /// the IAM
    /// credentials with.
    service_account: []const u8,

    pub const json_field_names = .{
        .namespace = "namespace",
        .service_account = "serviceAccount",
    };
};
