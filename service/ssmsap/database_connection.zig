const DatabaseConnectionMethod = @import("database_connection_method.zig").DatabaseConnectionMethod;

/// The connection specifications for the database.
pub const DatabaseConnection = struct {
    /// The IP address for connection.
    connection_ip: ?[]const u8,

    /// The Amazon Resource Name of the connected SAP HANA database.
    database_arn: ?[]const u8,

    /// The method of connection.
    database_connection_method: ?DatabaseConnectionMethod,

    pub const json_field_names = .{
        .connection_ip = "ConnectionIp",
        .database_arn = "DatabaseArn",
        .database_connection_method = "DatabaseConnectionMethod",
    };
};
