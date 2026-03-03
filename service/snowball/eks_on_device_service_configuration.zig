/// An object representing the metadata and configuration settings of EKS
/// Anywhere on the Snow Family device.
pub const EKSOnDeviceServiceConfiguration = struct {
    /// The optional version of EKS Anywhere on the Snow Family device.
    eks_anywhere_version: ?[]const u8 = null,

    /// The Kubernetes version for EKS Anywhere on the Snow Family device.
    kubernetes_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .eks_anywhere_version = "EKSAnywhereVersion",
        .kubernetes_version = "KubernetesVersion",
    };
};
