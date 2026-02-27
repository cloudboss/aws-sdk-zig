const ConnectionType = @import("connection_type.zig").ConnectionType;

/// Filters the connection definitions that are returned by the `GetConnections`
/// API operation.
pub const GetConnectionsFilter = struct {
    /// Denotes if the connection was created with schema version 1 or 2.
    connection_schema_version: ?i32,

    /// The type of connections to return. Currently, SFTP is not supported.
    connection_type: ?ConnectionType,

    /// A criteria string that must match the criteria recorded in the
    /// connection definition for that connection definition to be returned.
    match_criteria: ?[]const []const u8,

    pub const json_field_names = .{
        .connection_schema_version = "ConnectionSchemaVersion",
        .connection_type = "ConnectionType",
        .match_criteria = "MatchCriteria",
    };
};
