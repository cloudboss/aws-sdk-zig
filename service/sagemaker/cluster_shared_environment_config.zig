const FSxLustreConfig = @import("f_sx_lustre_config.zig").FSxLustreConfig;
const ClusterFSxLustreDeletionPolicy = @import("cluster_f_sx_lustre_deletion_policy.zig").ClusterFSxLustreDeletionPolicy;

/// The shared environment configuration for the restricted instance groups
/// (RIG).
pub const ClusterSharedEnvironmentConfig = struct {
    /// Configuration settings for an Amazon FSx for Lustre file system in the
    /// shared environment.
    f_sx_lustre_config: FSxLustreConfig,

    /// The deletion policy for the Amazon FSx for Lustre file system in the shared
    /// environment.
    f_sx_lustre_deletion_policy: ClusterFSxLustreDeletionPolicy,

    pub const json_field_names = .{
        .f_sx_lustre_config = "FSxLustreConfig",
        .f_sx_lustre_deletion_policy = "FSxLustreDeletionPolicy",
    };
};
