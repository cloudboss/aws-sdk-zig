/// Displays the settings that control the size and behavior of the connection
/// pool associated with a `DBProxyTarget`.
pub const ConnectionPoolConfigurationInfo = struct {
    /// The number of seconds for a proxy to wait for a connection to become
    /// available in the connection pool. Only applies when the proxy has opened its
    /// maximum number of connections and all connections are busy with client
    /// sessions.
    connection_borrow_timeout: ?i32,

    /// One or more SQL statements for the proxy to run when opening each new
    /// database connection. The setting is typically used with `SET` statements to
    /// make sure that each connection has identical settings. The query added here
    /// must be valid. For including multiple variables in a single SET statement,
    /// use a comma separator. This is an optional field.
    ///
    /// For example: `SET variable1=value1, variable2=value2`
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
    max_connections_percent: ?i32,

    /// Controls how actively the proxy closes idle database connections in the
    /// connection pool. The value is expressed as a percentage of the
    /// `max_connections` setting for the RDS DB instance or Aurora DB cluster used
    /// by the target group. With a high value, the proxy leaves a high percentage
    /// of idle database connections open. A low value causes the proxy to close
    /// more idle connections and return them to the database.
    max_idle_connections_percent: ?i32,

    /// Each item in the list represents a class of SQL operations that normally
    /// cause all later statements in a session using a proxy to be pinned to the
    /// same underlying database connection. Including an item in the list exempts
    /// that class of SQL operations from the pinning behavior. This setting is only
    /// supported for MySQL engine family databases. Currently, the only allowed
    /// value is `EXCLUDE_VARIABLE_SETS`.
    session_pinning_filters: ?[]const []const u8,
};
