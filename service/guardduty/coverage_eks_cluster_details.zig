const AddonDetails = @import("addon_details.zig").AddonDetails;
const ManagementType = @import("management_type.zig").ManagementType;

/// Information about the EKS cluster that has a coverage status.
pub const CoverageEksClusterDetails = struct {
    /// Information about the installed EKS add-on.
    addon_details: ?AddonDetails = null,

    /// Name of the EKS cluster.
    cluster_name: ?[]const u8 = null,

    /// Represents all the nodes within the EKS cluster in your account.
    compatible_nodes: ?i64 = null,

    /// Represents the nodes within the EKS cluster that have a `HEALTHY` coverage
    /// status.
    covered_nodes: ?i64 = null,

    /// Indicates how the Amazon EKS add-on GuardDuty agent is managed for this EKS
    /// cluster.
    ///
    /// `AUTO_MANAGED` indicates GuardDuty deploys and manages updates for this
    /// resource.
    ///
    /// `MANUAL` indicates that you are responsible to deploy, update, and manage
    /// the Amazon EKS add-on GuardDuty agent for this resource.
    management_type: ?ManagementType = null,

    pub const json_field_names = .{
        .addon_details = "AddonDetails",
        .cluster_name = "ClusterName",
        .compatible_nodes = "CompatibleNodes",
        .covered_nodes = "CoveredNodes",
        .management_type = "ManagementType",
    };
};
