const DestinationConfig = @import("destination_config.zig").DestinationConfig;
const ConnectionState = @import("connection_state.zig").ConnectionState;
const TunnelStatus = @import("tunnel_status.zig").TunnelStatus;
const Tag = @import("tag.zig").Tag;
const TimeoutConfig = @import("timeout_config.zig").TimeoutConfig;

/// A connection between a source computer and a destination device.
pub const Tunnel = struct {
    /// The time when the tunnel was created.
    created_at: ?i64,

    /// A description of the tunnel.
    description: ?[]const u8,

    /// The destination configuration that specifies the thing name of the
    /// destination
    /// device and a service name that the local proxy uses to connect to the
    /// destination
    /// application.
    destination_config: ?DestinationConfig,

    /// The connection state of the destination application.
    destination_connection_state: ?ConnectionState,

    /// The last time the tunnel was updated.
    last_updated_at: ?i64,

    /// The connection state of the source application.
    source_connection_state: ?ConnectionState,

    /// The status of a tunnel. Valid values are: Open and Closed.
    status: ?TunnelStatus,

    /// A list of tag metadata associated with the secure tunnel.
    tags: ?[]const Tag,

    /// Timeout configuration for the tunnel.
    timeout_config: ?TimeoutConfig,

    /// The Amazon Resource Name (ARN) of a tunnel.
    tunnel_arn: ?[]const u8,

    /// A unique alpha-numeric ID that identifies a tunnel.
    tunnel_id: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .destination_config = "destinationConfig",
        .destination_connection_state = "destinationConnectionState",
        .last_updated_at = "lastUpdatedAt",
        .source_connection_state = "sourceConnectionState",
        .status = "status",
        .tags = "tags",
        .timeout_config = "timeoutConfig",
        .tunnel_arn = "tunnelArn",
        .tunnel_id = "tunnelId",
    };
};
