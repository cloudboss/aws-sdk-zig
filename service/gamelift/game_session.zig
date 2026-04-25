const GameProperty = @import("game_property.zig").GameProperty;
const PlayerGatewayStatus = @import("player_gateway_status.zig").PlayerGatewayStatus;
const PlayerSessionCreationPolicy = @import("player_session_creation_policy.zig").PlayerSessionCreationPolicy;
const GameSessionStatus = @import("game_session_status.zig").GameSessionStatus;
const GameSessionStatusReason = @import("game_session_status_reason.zig").GameSessionStatusReason;

/// Properties describing a game session.
///
/// A game session in ACTIVE status can host players. When a game session ends,
/// its status
/// is set to `TERMINATED`.
///
/// Amazon GameLift Servers retains a game session resource for 30 days after
/// the game session ends. You
/// can reuse idempotency token values after this time. Game session logs are
/// retained for
/// 14 days.
///
/// [All APIs by
/// task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
pub const GameSession = struct {
    /// A descriptive label for the compute resource. The compute resource that is
    /// hosting the game session. For EC2 fleets, this is the EC2 instance ID. For
    /// Container fleets, each game server container group on a fleet instance is
    /// assigned a compute name. For Anywhere fleets, this is the custom compute
    /// name.
    compute_name: ?[]const u8 = null,

    /// A time stamp indicating when this data object was created. Format is a
    /// number expressed in Unix time as milliseconds (for example
    /// `"1469498468.057"`).
    creation_time: ?i64 = null,

    /// A unique identifier for a player. This ID is used to enforce a resource
    /// protection policy (if one exists),
    /// that limits the number of game sessions a player can create.
    creator_id: ?[]const u8 = null,

    /// Number of players currently in the game session.
    current_player_session_count: ?i32 = null,

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
    /// associated with the GameLift fleet that this game session is running on.
    fleet_arn: ?[]const u8 = null,

    /// A unique identifier for the fleet that the game session is running on.
    fleet_id: ?[]const u8 = null,

    /// A set of key-value pairs that can store custom data in a game session.
    /// For example: `{"Key": "difficulty", "Value": "novice"}`.
    ///
    /// * Avoid using periods (".") in property keys if you plan to search for game
    ///   sessions by properties. Property keys containing periods cannot be
    ///   searched and will be filtered out from search results due to search index
    ///   limitations.
    ///
    /// * If you use SearchGameSessions API, there is a limit of 500 game property
    ///   keys across all game sessions and all fleets per region. If the limit is
    ///   exceeded, there will potentially be game session entries missing from
    ///   SearchGameSessions API results.
    game_properties: ?[]const GameProperty = null,

    /// A set of custom game session properties, formatted as a single string value.
    /// This data is passed to a game server process with a request to start a new
    /// game session. For more information, see [Start a game
    /// session](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-sdk-server-api.html#gamelift-sdk-server-startsession).
    game_session_data: ?[]const u8 = null,

    /// A unique identifier for the game session. A game session ARN has the
    /// following format:
    /// `arn:aws:gamelift:::gamesession//`.
    game_session_id: ?[]const u8 = null,

    /// The IP address of the game session. To connect to a Amazon GameLift Servers
    /// game server, an app needs both the IP address and port number.
    ip_address: ?[]const u8 = null,

    /// The fleet location where the game session is running. This value might
    /// specify the
    /// fleet's home Region or a remote location. Location is expressed as an Amazon
    /// Web Services Region code
    /// such as `us-west-2`.
    location: ?[]const u8 = null,

    /// Information about the matchmaking process that resulted in the game session,
    /// if
    /// matchmaking was used. Data is in JSON syntax, formatted as a string.
    /// Information
    /// includes the matchmaker ID as well as player attributes and team
    /// assignments. For more
    /// details on matchmaker data, see [Match
    /// Data](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-server.html#match-server-data). Matchmaker data is updated whenever new players are added during a
    /// successful backfill (see
    /// [StartMatchBackfill](https://docs.aws.amazon.com/gamelift/latest/apireference/API_StartMatchBackfill.html)).
    matchmaker_data: ?[]const u8 = null,

    /// The maximum number of players that can be connected simultaneously to the
    /// game session.
    maximum_player_session_count: ?i32 = null,

    /// A descriptive label that is associated with a game session. Session names do
    /// not need to be unique.
    name: ?[]const u8 = null,

    /// Indicates whether player gateway is available for use for this game session.
    /// Note, even if a fleet has PlayerGatewayMode configured as `ENABLED`, player
    /// gateway might not be available in a specific location. For more information
    /// about locations where player gateway is supported, see [Amazon GameLift
    /// Servers service
    /// locations](https://docs.aws.amazon.com/gameliftservers/latest/developerguide/gamelift-regions.html).
    ///
    /// Possible values include:
    ///
    /// * `ENABLED` -- Player gateway is available for routing player connections
    ///   for this game session.
    ///
    /// * `DISABLED` -- Player gateway is not available for this game session.
    player_gateway_status: ?PlayerGatewayStatus = null,

    /// Indicates whether the game session is accepting new players.
    player_session_creation_policy: ?PlayerSessionCreationPolicy = null,

    /// The port number for the game session. To connect to a Amazon GameLift
    /// Servers game server, an app needs both the IP address and port number.
    port: ?i32 = null,

    /// Current status of the game session. A game session must have an `ACTIVE`
    /// status to have player sessions.
    status: ?GameSessionStatus = null,

    /// Provides additional information about game session status.
    ///
    /// * `INTERRUPTED` -- The game session was hosted on an EC2 Spot instance that
    ///   was
    /// reclaimed, causing the active game session to be stopped.
    ///
    /// * `TRIGGERED_ON_PROCESS_TERMINATE` – The game session was stopped by calling
    /// `TerminateGameSession` with the termination mode
    /// `TRIGGER_ON_PROCESS_TERMINATE`.
    ///
    /// * `FORCE_TERMINATED` – The game session was stopped by calling
    /// `TerminateGameSession` with the termination mode
    /// `FORCE_TERMINATE`.
    status_reason: ?GameSessionStatusReason = null,

    /// A time stamp indicating when this data object was terminated. Format is a
    /// number expressed in Unix time as milliseconds (for example
    /// `"1469498468.057"`).
    termination_time: ?i64 = null,

    pub const json_field_names = .{
        .compute_name = "ComputeName",
        .creation_time = "CreationTime",
        .creator_id = "CreatorId",
        .current_player_session_count = "CurrentPlayerSessionCount",
        .dns_name = "DnsName",
        .fleet_arn = "FleetArn",
        .fleet_id = "FleetId",
        .game_properties = "GameProperties",
        .game_session_data = "GameSessionData",
        .game_session_id = "GameSessionId",
        .ip_address = "IpAddress",
        .location = "Location",
        .matchmaker_data = "MatchmakerData",
        .maximum_player_session_count = "MaximumPlayerSessionCount",
        .name = "Name",
        .player_gateway_status = "PlayerGatewayStatus",
        .player_session_creation_policy = "PlayerSessionCreationPolicy",
        .port = "Port",
        .status = "Status",
        .status_reason = "StatusReason",
        .termination_time = "TerminationTime",
    };
};
