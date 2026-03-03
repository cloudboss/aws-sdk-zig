const TunnelStatus = @import("tunnel_status.zig").TunnelStatus;

/// Information about the tunnel.
pub const TunnelSummary = struct {
    /// The time the tunnel was created.
    created_at: ?i64 = null,

    /// A description of the tunnel.
    description: ?[]const u8 = null,

    /// The time the tunnel was last updated.
    last_updated_at: ?i64 = null,

    /// The status of a tunnel. Valid values are: Open and Closed.
    status: ?TunnelStatus = null,

    /// The Amazon Resource Name of the tunnel.
    tunnel_arn: ?[]const u8 = null,

    /// The unique alpha-numeric identifier for the tunnel.
    tunnel_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .last_updated_at = "lastUpdatedAt",
        .status = "status",
        .tunnel_arn = "tunnelArn",
        .tunnel_id = "tunnelId",
    };
};
