/// Describes a server in a Fleet Advisor collector inventory.
pub const ServerShortInfoResponse = struct {
    /// The IP address of a server in a Fleet Advisor collector inventory.
    ip_address: ?[]const u8,

    /// The ID of a server in a Fleet Advisor collector inventory.
    server_id: ?[]const u8,

    /// The name address of a server in a Fleet Advisor collector inventory.
    server_name: ?[]const u8,

    pub const json_field_names = .{
        .ip_address = "IpAddress",
        .server_id = "ServerId",
        .server_name = "ServerName",
    };
};
