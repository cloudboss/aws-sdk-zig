const ConnectionState = @import("connection_state.zig").ConnectionState;
const Tag = @import("tag.zig").Tag;

/// Describes a connection.
pub const Connection = struct {
    /// The ID of the second device in the connection.
    connected_device_id: ?[]const u8,

    /// The ID of the link for the second device in the connection.
    connected_link_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the connection.
    connection_arn: ?[]const u8,

    /// The ID of the connection.
    connection_id: ?[]const u8,

    /// The date and time that the connection was created.
    created_at: ?i64,

    /// The description of the connection.
    description: ?[]const u8,

    /// The ID of the first device in the connection.
    device_id: ?[]const u8,

    /// The ID of the global network.
    global_network_id: ?[]const u8,

    /// The ID of the link for the first device in the connection.
    link_id: ?[]const u8,

    /// The state of the connection.
    state: ?ConnectionState,

    /// The tags for the connection.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .connected_device_id = "ConnectedDeviceId",
        .connected_link_id = "ConnectedLinkId",
        .connection_arn = "ConnectionArn",
        .connection_id = "ConnectionId",
        .created_at = "CreatedAt",
        .description = "Description",
        .device_id = "DeviceId",
        .global_network_id = "GlobalNetworkId",
        .link_id = "LinkId",
        .state = "State",
        .tags = "Tags",
    };
};
