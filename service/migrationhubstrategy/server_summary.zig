const ServerOsType = @import("server_os_type.zig").ServerOsType;

/// Object containing details about the servers imported by Application
/// Discovery Service
pub const ServerSummary = struct {
    /// Number of servers.
    count: ?i32 = null,

    /// Type of operating system for the servers.
    server_os_type: ?ServerOsType = null,

    pub const json_field_names = .{
        .count = "count",
        .server_os_type = "ServerOsType",
    };
};
