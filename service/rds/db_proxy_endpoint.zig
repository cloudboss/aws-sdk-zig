const EndpointNetworkType = @import("endpoint_network_type.zig").EndpointNetworkType;
const DBProxyEndpointStatus = @import("db_proxy_endpoint_status.zig").DBProxyEndpointStatus;
const DBProxyEndpointTargetRole = @import("db_proxy_endpoint_target_role.zig").DBProxyEndpointTargetRole;

/// The data structure representing an endpoint associated with a DB proxy. RDS
/// automatically creates one endpoint for each DB proxy. For Aurora DB
/// clusters, you can associate additional endpoints with the same DB proxy.
/// These endpoints can be read/write or read-only. They can also reside in
/// different VPCs than the associated DB proxy.
///
/// This data type is used as a response element in the
/// `DescribeDBProxyEndpoints` operation.
pub const DBProxyEndpoint = struct {
    /// The date and time when the DB proxy endpoint was first created.
    created_date: ?i64 = null,

    /// The Amazon Resource Name (ARN) for the DB proxy endpoint.
    db_proxy_endpoint_arn: ?[]const u8 = null,

    /// The name for the DB proxy endpoint. An identifier must begin with a letter
    /// and must contain only ASCII letters, digits, and hyphens; it can't end with
    /// a hyphen or contain two consecutive hyphens.
    db_proxy_endpoint_name: ?[]const u8 = null,

    /// The identifier for the DB proxy that is associated with this DB proxy
    /// endpoint.
    db_proxy_name: ?[]const u8 = null,

    /// The endpoint that you can use to connect to the DB proxy. You include the
    /// endpoint value in the connection string for a database client application.
    endpoint: ?[]const u8 = null,

    /// The network type of the DB proxy endpoint. The network type determines the
    /// IP version that the proxy endpoint supports.
    ///
    /// Valid values:
    ///
    /// * `IPV4` - The proxy endpoint supports IPv4 only.
    /// * `IPV6` - The proxy endpoint supports IPv6 only.
    /// * `DUAL` - The proxy endpoint supports both IPv4 and IPv6.
    endpoint_network_type: ?EndpointNetworkType = null,

    /// Indicates whether this endpoint is the default endpoint for the associated
    /// DB proxy. Default DB proxy endpoints always have read/write capability.
    /// Other endpoints that you associate with the DB proxy can be either
    /// read/write or read-only.
    is_default: ?bool = null,

    /// The current status of this DB proxy endpoint. A status of `available` means
    /// the endpoint is ready to handle requests. Other values indicate that you
    /// must wait for the endpoint to be ready, or take some action to resolve an
    /// issue.
    status: ?DBProxyEndpointStatus = null,

    /// A value that indicates whether the DB proxy endpoint can be used for
    /// read/write or read-only operations.
    target_role: ?DBProxyEndpointTargetRole = null,

    /// Provides the VPC ID of the DB proxy endpoint.
    vpc_id: ?[]const u8 = null,

    /// Provides a list of VPC security groups that the DB proxy endpoint belongs
    /// to.
    vpc_security_group_ids: ?[]const []const u8 = null,

    /// The EC2 subnet IDs for the DB proxy endpoint.
    vpc_subnet_ids: ?[]const []const u8 = null,
};
