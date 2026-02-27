const AuthenticationMode = @import("authentication_mode.zig").AuthenticationMode;

/// The access configuration information for the cluster.
pub const CreateAccessConfigRequest = struct {
    /// The desired authentication mode for the cluster. If you create a cluster by
    /// using the
    /// EKS API, Amazon Web Services SDKs, or CloudFormation, the default is
    /// `CONFIG_MAP`. If you create
    /// the cluster by using the Amazon Web Services Management Console, the default
    /// value is
    /// `API_AND_CONFIG_MAP`.
    authentication_mode: ?AuthenticationMode,

    /// Specifies whether or not the cluster creator IAM principal was set as a
    /// cluster
    /// admin access entry during cluster creation time. The default value is
    /// `true`.
    bootstrap_cluster_creator_admin_permissions: ?bool,

    pub const json_field_names = .{
        .authentication_mode = "authenticationMode",
        .bootstrap_cluster_creator_admin_permissions = "bootstrapClusterCreatorAdminPermissions",
    };
};
