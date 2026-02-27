const AuthenticationMode = @import("authentication_mode.zig").AuthenticationMode;

/// The access configuration for the cluster.
pub const AccessConfigResponse = struct {
    /// The current authentication mode of the cluster.
    authentication_mode: ?AuthenticationMode,

    /// Specifies whether or not the cluster creator IAM principal was set as a
    /// cluster
    /// admin access entry during cluster creation time.
    bootstrap_cluster_creator_admin_permissions: ?bool,

    pub const json_field_names = .{
        .authentication_mode = "authenticationMode",
        .bootstrap_cluster_creator_admin_permissions = "bootstrapClusterCreatorAdminPermissions",
    };
};
