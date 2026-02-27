const AuthorizationStatus = @import("authorization_status.zig").AuthorizationStatus;

/// Describes an endpoint authorization for authorizing Redshift-managed VPC
/// endpoint access to a cluster across Amazon Web Services accounts.
pub const EndpointAuthorization = struct {
    /// Indicates whether all VPCs in the grantee account are allowed access to the
    /// cluster.
    allowed_all_vp_cs: ?bool,

    /// The VPCs allowed access to the cluster.
    allowed_vp_cs: ?[]const []const u8,

    /// The time (UTC) when the authorization was created.
    authorize_time: ?i64,

    /// The cluster identifier.
    cluster_identifier: ?[]const u8,

    /// The status of the cluster.
    cluster_status: ?[]const u8,

    /// The number of Redshift-managed VPC endpoints created for the authorization.
    endpoint_count: ?i32,

    /// The Amazon Web Services account ID of the grantee of the cluster.
    grantee: ?[]const u8,

    /// The Amazon Web Services account ID of the cluster owner.
    grantor: ?[]const u8,

    /// The status of the authorization action.
    status: ?AuthorizationStatus,
};
