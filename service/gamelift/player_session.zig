const PlayerSessionStatus = @import("player_session_status.zig").PlayerSessionStatus;

/// Represents a player session. Player sessions are created either for a
/// specific game
/// session, or as part of a game session placement or matchmaking request. A
/// player session
/// can represents a reserved player slot in a game session (when status is
/// `RESERVED`) or actual player activity in a game session (when status is
/// `ACTIVE`). A player session object, including player data, is
/// automatically passed to a game session when the player connects to the game
/// session and
/// is validated. After the game session ends, player sessions information is
/// retained for
/// 30 days and then removed.
///
/// **Related actions**
///
/// [All APIs by
/// task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
pub const PlayerSession = struct {
    /// A time stamp indicating when this data object was created. Format is a
    /// number expressed in Unix time as milliseconds (for example
    /// `"1469498468.057"`).
    creation_time: ?i64 = null,

    /// The DNS identifier assigned to the instance that is running the game
    /// session. Values have
    /// the following format:
    ///
    /// * TLS-enabled fleets: `..amazongamelift.com`.
    ///
    /// * Non-TLS-enabled fleets: `ec2-.compute.amazonaws.com`. (See
    /// [Amazon EC2 Instance IP
    /// Addressing](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-instance-addressing.html#concepts-public-addresses).)
    ///
    /// When connecting to a game session that is running on a TLS-enabled fleet,
    /// you must use the DNS name, not the IP address.
    dns_name: ?[]const u8 = null,

    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// associated with the GameLift fleet that the player's game session is
    /// running on.
    fleet_arn: ?[]const u8 = null,

    /// A unique identifier for the fleet that the player's game session is running
    /// on.
    fleet_id: ?[]const u8 = null,

    /// A unique identifier for the game session that the player session is
    /// connected to.
    game_session_id: ?[]const u8 = null,

    /// The IP address of the game session. To connect to a Amazon GameLift Servers
    /// game server, an app needs both the IP address and port number.
    ip_address: ?[]const u8 = null,

    /// Developer-defined information related to a player. Amazon GameLift Servers
    /// does not use this data, so it can be formatted as needed for use in the
    /// game.
    player_data: ?[]const u8 = null,

    /// A unique identifier for a player that is associated with this player
    /// session.
    player_id: ?[]const u8 = null,

    /// A unique identifier for a player session.
    player_session_id: ?[]const u8 = null,

    /// Port number for the game session. To connect to a Amazon GameLift Servers
    /// server process, an app needs
    /// both the IP address and port number.
    port: ?i32 = null,

    /// Current status of the player session.
    ///
    /// Possible player session statuses include the following:
    ///
    /// * **RESERVED** -- The player session request has been
    /// received, but the player has not yet connected to the server process and/or
    /// been
    /// validated.
    ///
    /// * **ACTIVE** -- The player has been validated by the
    /// server process and is currently connected.
    ///
    /// * **COMPLETED** -- The player connection has been
    /// dropped.
    ///
    /// * **TIMEDOUT** -- A player session request was
    /// received, but the player did not connect and/or was not validated within the
    /// timeout limit (60 seconds).
    status: ?PlayerSessionStatus = null,

    /// A time stamp indicating when this data object was terminated. Format is a
    /// number expressed in Unix time as milliseconds (for example
    /// `"1469498468.057"`).
    termination_time: ?i64 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .dns_name = "DnsName",
        .fleet_arn = "FleetArn",
        .fleet_id = "FleetId",
        .game_session_id = "GameSessionId",
        .ip_address = "IpAddress",
        .player_data = "PlayerData",
        .player_id = "PlayerId",
        .player_session_id = "PlayerSessionId",
        .port = "Port",
        .status = "Status",
        .termination_time = "TerminationTime",
    };
};
