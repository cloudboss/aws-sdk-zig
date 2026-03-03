const ClusterVersionStatus = @import("cluster_version_status.zig").ClusterVersionStatus;
const VersionStatus = @import("version_status.zig").VersionStatus;

/// Contains details about a specific EKS cluster version.
pub const ClusterVersionInformation = struct {
    /// The type of cluster this version is for.
    cluster_type: ?[]const u8 = null,

    /// The Kubernetes version for the cluster.
    cluster_version: ?[]const u8 = null,

    /// Default platform version for this Kubernetes version.
    default_platform_version: ?[]const u8 = null,

    /// Indicates if this is a default version.
    default_version: bool = false,

    /// Date when extended support ends for this version.
    end_of_extended_support_date: ?i64 = null,

    /// Date when standard support ends for this version.
    end_of_standard_support_date: ?i64 = null,

    /// The patch version of Kubernetes for this cluster version.
    kubernetes_patch_version: ?[]const u8 = null,

    /// The release date of this cluster version.
    release_date: ?i64 = null,

    /// This field is deprecated. Use `versionStatus` instead, as that field
    /// matches for input and output of this action.
    ///
    /// Current status of this cluster version.
    status: ?ClusterVersionStatus = null,

    /// Current status of this cluster version.
    version_status: ?VersionStatus = null,

    pub const json_field_names = .{
        .cluster_type = "clusterType",
        .cluster_version = "clusterVersion",
        .default_platform_version = "defaultPlatformVersion",
        .default_version = "defaultVersion",
        .end_of_extended_support_date = "endOfExtendedSupportDate",
        .end_of_standard_support_date = "endOfStandardSupportDate",
        .kubernetes_patch_version = "kubernetesPatchVersion",
        .release_date = "releaseDate",
        .status = "status",
        .version_status = "versionStatus",
    };
};
