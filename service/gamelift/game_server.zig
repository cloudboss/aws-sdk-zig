const GameServerClaimStatus = @import("game_server_claim_status.zig").GameServerClaimStatus;
const GameServerUtilizationStatus = @import("game_server_utilization_status.zig").GameServerUtilizationStatus;

/// Properties describing a game server that
/// is running on an instance in a game server group.
///
/// A game server is created by a successful call to `RegisterGameServer` and
/// deleted by calling `DeregisterGameServer`. A game server is claimed to host
/// a
/// game session by calling `ClaimGameServer`.
pub const GameServer = struct {
    /// Indicates when an available game server has been reserved for gameplay but
    /// has not yet
    /// started hosting a game. Once it is claimed, the game server remains in
    /// `CLAIMED` status for a maximum of one minute. During this time, game
    /// clients connect to the game server to start the game and trigger the game
    /// server to
    /// update its utilization status. After one minute, the game server claim
    /// status reverts to
    /// null.
    claim_status: ?GameServerClaimStatus = null,

    /// The port and IP address that must be used to establish a client connection
    /// to the game
    /// server.
    connection_info: ?[]const u8 = null,

    /// A set of custom game server properties, formatted as a single string value.
    /// This data
    /// is passed to a game client or service when it requests information on game
    /// servers.
    game_server_data: ?[]const u8 = null,

    /// The ARN identifier for the game server group where the game server is
    /// located.
    game_server_group_arn: ?[]const u8 = null,

    /// A unique identifier for the game server group where the game server is
    /// running.
    game_server_group_name: ?[]const u8 = null,

    /// A custom string that uniquely identifies the game server. Game server IDs
    /// are developer-defined and are unique across all game
    /// server groups in an Amazon Web Services account.
    game_server_id: ?[]const u8 = null,

    /// The unique identifier for the instance where the game server is running.
    /// This ID is
    /// available in the instance metadata. EC2 instance IDs
    /// use a 17-character format, for example: `i-1234567890abcdef0`.
    instance_id: ?[]const u8 = null,

    /// Timestamp that indicates the last time the game server was claimed. The
    /// format is a
    /// number expressed in Unix time as milliseconds (for example
    /// `"1469498468.057"`). This value is used to calculate when a claimed game
    /// server's status should revert to null.
    last_claim_time: ?i64 = null,

    /// Timestamp that indicates the last time the game server was updated with
    /// health status.
    /// The format is a number expressed in Unix time as milliseconds (for example
    /// `"1469498468.057"`). After game server registration, this property is
    /// only changed when a game server update specifies a health check value.
    last_health_check_time: ?i64 = null,

    /// Timestamp that indicates when the game server registered. The format is a
    /// number expressed in Unix
    /// time as milliseconds (for example `"1469498468.057"`).
    registration_time: ?i64 = null,

    /// Indicates whether the game server is currently available for new games or is
    /// busy.
    /// Possible statuses include:
    ///
    /// * `AVAILABLE` - The game server is available to be claimed. A game
    /// server that has been claimed remains in this status until it reports game
    /// hosting activity.
    ///
    /// * `UTILIZED` - The game server is currently hosting a game session
    /// with players.
    utilization_status: ?GameServerUtilizationStatus = null,

    pub const json_field_names = .{
        .claim_status = "ClaimStatus",
        .connection_info = "ConnectionInfo",
        .game_server_data = "GameServerData",
        .game_server_group_arn = "GameServerGroupArn",
        .game_server_group_name = "GameServerGroupName",
        .game_server_id = "GameServerId",
        .instance_id = "InstanceId",
        .last_claim_time = "LastClaimTime",
        .last_health_check_time = "LastHealthCheckTime",
        .registration_time = "RegistrationTime",
        .utilization_status = "UtilizationStatus",
    };
};
