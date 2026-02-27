/// Specifies the settings that control the size and behavior of the connection
/// pool associated with a `DBProxyTargetGroup`.
pub const ConnectionPoolConfiguration = struct {
    /// The number of seconds for a proxy to wait for a connection to become
    /// available in the connection pool. This setting only applies when the proxy
    /// has opened its maximum number of connections and all connections are busy
    /// with client sessions.
    ///
    /// Default: `120`
    ///
    /// Constraints:
    ///
    /// * Must be between 0 and 300.
    connection_borrow_timeout: ?i32,

    /// Add an initialization query, or modify the current one. You can specify one
    /// or more SQL statements for the proxy to run when opening each new database
    /// connection. The setting is typically used with `SET` statements to make sure
    /// that each connection has identical settings. Make sure the query added here
    /// is valid. This is an optional field, so you can choose to leave it empty.
    /// For including multiple variables in a single SET statement, use a comma
    /// separator.
    ///
    /// For example: `SET variable1=value1, variable2=value2`
    ///
    /// Default: no initialization query
    ///
    /// Since you can access initialization query as part of target group
    /// configuration, it is not protected by authentication or cryptographic
    /// methods. Anyone with access to view or manage your proxy target group
    /// configuration can view the initialization query. You should not add
    /// sensitive data, such as passwords or long-lived encryption keys, to this
    /// option.
    init_query: ?[]const u8,

    /// The maximum size of the connection pool for each target in a target group.
    /// The value is expressed as a percentage of the `max_connections` setting for
    /// the RDS DB instance or Aurora DB cluster used by the target group.
    ///
    /// If you specify `MaxIdleConnectionsPercent`, then you must also include a
    /// value for this parameter.
    ///
    /// Default: `10` for RDS for Microsoft SQL Server, and `100` for all other
    /// engines
    ///
    /// Constraints:
    ///
    /// * Must be between 1 and 100.
    max_connections_percent: ?i32,

    /// A value that controls how actively the proxy closes idle database
    /// connections in the connection pool. The value is expressed as a percentage
    /// of the `max_connections` setting for the RDS DB instance or Aurora DB
    /// cluster used by the target group. With a high value, the proxy leaves a high
    /// percentage of idle database connections open. A low value causes the proxy
    /// to close more idle connections and return them to the database.
    ///
    /// If you specify this parameter, then you must also include a value for
    /// `MaxConnectionsPercent`.
    ///
    /// Default: The default value is half of the value of `MaxConnectionsPercent`.
    /// For example, if `MaxConnectionsPercent` is 80, then the default value of
    /// `MaxIdleConnectionsPercent` is 40. If the value of `MaxConnectionsPercent`
    /// isn't specified, then for SQL Server, `MaxIdleConnectionsPercent` is `5`,
    /// and for all other engines, the default is `50`.
    ///
    /// Constraints:
    ///
    /// * Must be between 0 and the value of `MaxConnectionsPercent`.
    max_idle_connections_percent: ?i32,

    /// Each item in the list represents a class of SQL operations that normally
    /// cause all later statements in a session using a proxy to be pinned to the
    /// same underlying database connection. Including an item in the list exempts
    /// that class of SQL operations from the pinning behavior.
    ///
    /// Default: no session pinning filters
    session_pinning_filters: ?[]const []const u8,
};
