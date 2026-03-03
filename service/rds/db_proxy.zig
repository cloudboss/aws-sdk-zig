const UserAuthConfigInfo = @import("user_auth_config_info.zig").UserAuthConfigInfo;
const EndpointNetworkType = @import("endpoint_network_type.zig").EndpointNetworkType;
const DBProxyStatus = @import("db_proxy_status.zig").DBProxyStatus;
const TargetConnectionNetworkType = @import("target_connection_network_type.zig").TargetConnectionNetworkType;

/// The data structure representing a proxy managed by the RDS Proxy.
///
/// This data type is used as a response element in the `DescribeDBProxies`
/// action.
pub const DBProxy = struct {
    /// One or more data structures specifying the authorization mechanism to
    /// connect to the associated RDS DB instance or Aurora DB cluster.
    auth: ?[]const UserAuthConfigInfo = null,

    /// The date and time when the proxy was first created.
    created_date: ?i64 = null,

    /// The Amazon Resource Name (ARN) for the proxy.
    db_proxy_arn: ?[]const u8 = null,

    /// The identifier for the proxy. This name must be unique for all proxies owned
    /// by your Amazon Web Services account in the specified Amazon Web Services
    /// Region.
    db_proxy_name: ?[]const u8 = null,

    /// Specifies whether the proxy logs detailed connection and query information.
    /// When you enable `DebugLogging`, the proxy captures connection details and
    /// connection pool behavior from your queries. Debug logging increases
    /// CloudWatch costs and can impact proxy performance. Enable this option only
    /// when you need to troubleshoot connection or performance issues.
    debug_logging: ?bool = null,

    /// The default authentication scheme that the proxy uses for client connections
    /// to the proxy and connections from the proxy to the underlying database.
    /// Valid values are `NONE` and `IAM_AUTH`. When set to `IAM_AUTH`, the proxy
    /// uses end-to-end IAM authentication to connect to the database.
    default_auth_scheme: ?[]const u8 = null,

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

    /// The kinds of databases that the proxy can connect to. This value determines
    /// which database network protocol the proxy recognizes when it interprets
    /// network traffic to and from the database. `MYSQL` supports Aurora MySQL, RDS
    /// for MariaDB, and RDS for MySQL databases. `POSTGRESQL` supports Aurora
    /// PostgreSQL and RDS for PostgreSQL databases. `SQLSERVER` supports RDS for
    /// Microsoft SQL Server databases.
    engine_family: ?[]const u8 = null,

    /// The number of seconds a connection to the proxy can have no activity before
    /// the proxy drops the client connection. The proxy keeps the underlying
    /// database connection open and puts it back into the connection pool for reuse
    /// by later connection requests.
    ///
    /// Default: 1800 (30 minutes)
    ///
    /// Constraints: 1 to 28,800
    idle_client_timeout: ?i32 = null,

    /// Indicates whether Transport Layer Security (TLS) encryption is required for
    /// connections to the proxy.
    require_tls: ?bool = null,

    /// The Amazon Resource Name (ARN) for the IAM role that the proxy uses to
    /// access Amazon Secrets Manager.
    role_arn: ?[]const u8 = null,

    /// The current status of this proxy. A status of `available` means the proxy is
    /// ready to handle requests. Other values indicate that you must wait for the
    /// proxy to be ready, or take some action to resolve an issue.
    status: ?DBProxyStatus = null,

    /// The network type that the proxy uses to connect to the target database. The
    /// network type determines the IP version that the proxy uses for connections
    /// to the database.
    ///
    /// Valid values:
    ///
    /// * `IPV4` - The proxy connects to the database using IPv4 only.
    /// * `IPV6` - The proxy connects to the database using IPv6 only.
    target_connection_network_type: ?TargetConnectionNetworkType = null,

    /// The date and time when the proxy was last updated.
    updated_date: ?i64 = null,

    /// Provides the VPC ID of the DB proxy.
    vpc_id: ?[]const u8 = null,

    /// Provides a list of VPC security groups that the proxy belongs to.
    vpc_security_group_ids: ?[]const []const u8 = null,

    /// The EC2 subnet IDs for the proxy.
    vpc_subnet_ids: ?[]const []const u8 = null,
};
