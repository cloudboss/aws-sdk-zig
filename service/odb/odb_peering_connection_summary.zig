const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// A summary of an ODB peering connection.
pub const OdbPeeringConnectionSummary = struct {
    /// The timestamp when the ODB peering connection was created.
    created_at: ?i64,

    /// The display name of the ODB peering connection.
    display_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the ODB network that initiated the peering
    /// connection.
    odb_network_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the ODB peering connection.
    odb_peering_connection_arn: ?[]const u8,

    /// The unique identifier of the ODB peering connection. A sample ID is
    /// `odbpcx-abcdefgh12345678`.
    odb_peering_connection_id: []const u8,

    /// The type of the ODB peering connection.
    ///
    /// Valid Values: `ODB-VPC | ODB-ODB`
    odb_peering_connection_type: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the peer network.
    peer_network_arn: ?[]const u8,

    /// The CIDR blocks associated with the peering connection. These CIDR blocks
    /// define the IP address ranges that can communicate through the peering
    /// connection.
    peer_network_cidrs: ?[]const []const u8,

    /// The percentage progress of the ODB peering connection creation or deletion.
    percent_progress: ?f32,

    /// The status of the ODB peering connection.
    status: ?ResourceStatus,

    /// The reason for the current status of the ODB peering connection.
    status_reason: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .display_name = "displayName",
        .odb_network_arn = "odbNetworkArn",
        .odb_peering_connection_arn = "odbPeeringConnectionArn",
        .odb_peering_connection_id = "odbPeeringConnectionId",
        .odb_peering_connection_type = "odbPeeringConnectionType",
        .peer_network_arn = "peerNetworkArn",
        .peer_network_cidrs = "peerNetworkCidrs",
        .percent_progress = "percentProgress",
        .status = "status",
        .status_reason = "statusReason",
    };
};
