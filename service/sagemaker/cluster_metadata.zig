/// Metadata information about a HyperPod cluster showing information about the
/// cluster level operations, such as creating, updating, and deleting.
pub const ClusterMetadata = struct {
    /// A list of Amazon EKS IAM role ARNs associated with the cluster. This is
    /// created by HyperPod on your behalf and only applies for EKS orchestrated
    /// clusters.
    eks_role_access_entries: ?[]const []const u8,

    /// An error message describing why the cluster level operation (such as
    /// creating, updating, or deleting) failed.
    failure_message: ?[]const u8,

    /// The Service-Linked Role (SLR) associated with the cluster. This is created
    /// by HyperPod on your behalf and only applies for EKS orchestrated clusters.
    slr_access_entry: ?[]const u8,

    pub const json_field_names = .{
        .eks_role_access_entries = "EksRoleAccessEntries",
        .failure_message = "FailureMessage",
        .slr_access_entry = "SlrAccessEntry",
    };
};
