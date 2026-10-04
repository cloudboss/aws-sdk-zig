const FSxLustreConfig = @import("f_sx_lustre_config.zig").FSxLustreConfig;
const ClusterFSxLustreDeletionPolicy = @import("cluster_f_sx_lustre_deletion_policy.zig").ClusterFSxLustreDeletionPolicy;

/// The shared environment configuration details for the restricted instance
/// groups (RIG).
pub const ClusterSharedEnvironmentConfigDetails = struct {
    /// The current Amazon FSx for Lustre file system configuration in the shared
    /// environment.
    current_f_sx_lustre_config: ?FSxLustreConfig = null,

    /// The current deletion policy for the Amazon FSx for Lustre file system in the
    /// shared environment.
    current_f_sx_lustre_deletion_policy: ?ClusterFSxLustreDeletionPolicy = null,

    /// The desired Amazon FSx for Lustre file system configuration in the shared
    /// environment.
    desired_f_sx_lustre_config: ?FSxLustreConfig = null,

    /// The desired deletion policy for the Amazon FSx for Lustre file system in the
    /// shared environment.
    desired_f_sx_lustre_deletion_policy: ?ClusterFSxLustreDeletionPolicy = null,

    pub const json_field_names = .{
        .current_f_sx_lustre_config = "CurrentFSxLustreConfig",
        .current_f_sx_lustre_deletion_policy = "CurrentFSxLustreDeletionPolicy",
        .desired_f_sx_lustre_config = "DesiredFSxLustreConfig",
        .desired_f_sx_lustre_deletion_policy = "DesiredFSxLustreDeletionPolicy",
    };
};
