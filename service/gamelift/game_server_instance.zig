const GameServerInstanceStatus = @import("game_server_instance_status.zig").GameServerInstanceStatus;

/// Additional properties,
/// including status, that describe an EC2 instance in a game server group.
/// Instance
/// configurations are set with game server group properties (see
/// `DescribeGameServerGroup` and with the EC2 launch template that was used
/// when creating the game server group.
///
/// Retrieve game server instances for a game server group by calling
/// `DescribeGameServerInstances`.
pub const GameServerInstance = struct {
    /// A generated unique identifier for the game server group that includes the
    /// game server
    /// instance.
    game_server_group_arn: ?[]const u8 = null,

    /// A developer-defined identifier for the game server group that includes the
    /// game server
    /// instance. The name is unique for each Region in each Amazon Web Services
    /// account.
    game_server_group_name: ?[]const u8 = null,

    /// The unique identifier for the instance where the game server is running.
    /// This ID is
    /// available in the instance metadata. EC2 instance IDs
    /// use a 17-character format, for example: `i-1234567890abcdef0`.
    instance_id: ?[]const u8 = null,

    /// Current status of the game server instance
    instance_status: ?GameServerInstanceStatus = null,

    pub const json_field_names = .{
        .game_server_group_arn = "GameServerGroupArn",
        .game_server_group_name = "GameServerGroupName",
        .instance_id = "InstanceId",
        .instance_status = "InstanceStatus",
    };
};
