const Tag = @import("tag.zig").Tag;

pub const CreateConnectionRequest = struct {
    /// The bandwidth of the connection.
    bandwidth: []const u8,

    /// The name of the connection.
    connection_name: []const u8,

    /// The ID of the LAG.
    lag_id: ?[]const u8,

    /// The location of the connection.
    location: []const u8,

    /// The name of the service provider associated with the requested connection.
    provider_name: ?[]const u8,

    /// Indicates whether you want the connection to support MAC Security (MACsec).
    ///
    /// MAC Security (MACsec) is unavailable on hosted connections. For information
    /// about MAC Security (MACsec) prerequisites, see [MAC Security in Direct
    /// Connect](https://docs.aws.amazon.com/directconnect/latest/UserGuide/MACSec.html) in the *Direct Connect User Guide*.
    request_mac_sec: ?bool,

    /// The tags to associate with the lag.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .bandwidth = "bandwidth",
        .connection_name = "connectionName",
        .lag_id = "lagId",
        .location = "location",
        .provider_name = "providerName",
        .request_mac_sec = "requestMACSec",
        .tags = "tags",
    };
};
