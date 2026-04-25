const GameProperty = @import("game_property.zig").GameProperty;
const PlacedPlayerSession = @import("placed_player_session.zig").PlacedPlayerSession;
const PlayerGatewayStatus = @import("player_gateway_status.zig").PlayerGatewayStatus;
const PlayerLatency = @import("player_latency.zig").PlayerLatency;
const PriorityConfigurationOverride = @import("priority_configuration_override.zig").PriorityConfigurationOverride;
const GameSessionPlacementState = @import("game_session_placement_state.zig").GameSessionPlacementState;

/// Represents a potential game session placement, including the full details of
/// the
/// original placement request and the current status.
///
/// If the game session placement status is `PENDING`, the properties for game
/// session ID/ARN, region, IP address/DNS, and port aren't final. A game
/// session is not
/// active and ready to accept players until placement status reaches
/// `FULFILLED`. When the placement is in `PENDING` status,
/// Amazon GameLift Servers may attempt to place a game session multiple times
/// before succeeding. With
/// each attempt it creates a
/// [https://docs.aws.amazon.com/gamelift/latest/apireference/API_GameSession](https://docs.aws.amazon.com/gamelift/latest/apireference/API_GameSession) object and updates this
/// placement object with the new game session properties.
pub const GameSessionPlacement = struct {
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

    /// Time stamp indicating when this request was completed, canceled, or timed
    /// out.
    end_time: ?i64 = null,

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

    /// Identifier for the game session created by this placement request. This
    /// identifier is
    /// unique across all Regions. This value isn't final until placement status is
    /// `FULFILLED`.
    game_session_arn: ?[]const u8 = null,

    /// A set of custom game session properties, formatted as a single string value.
    /// This data is passed to a game server process with a request to start a new
    /// game session. For more information, see [Start a game
    /// session](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-sdk-server-api.html#gamelift-sdk-server-startsession).
    game_session_data: ?[]const u8 = null,

    /// A unique identifier for the game session. This value isn't final until
    /// placement status is
    /// `FULFILLED`.
    game_session_id: ?[]const u8 = null,

    /// A descriptive label that is associated with a game session. Session names do
    /// not need to be unique.
    game_session_name: ?[]const u8 = null,

    /// A descriptive label that is associated with game session queue. Queue names
    /// must be unique within each Region.
    game_session_queue_name: ?[]const u8 = null,

    /// Name of the Region where the game session created by this placement request
    /// is
    /// running. This value isn't final until placement status is `FULFILLED`.
    game_session_region: ?[]const u8 = null,

    /// The IP address of the game session. To connect to a Amazon GameLift Servers
    /// game server, an app needs both the IP address and port number. This value
    /// isn't final until placement status is `FULFILLED`.
    ip_address: ?[]const u8 = null,

    /// Information on the matchmaking process for this game. Data is in JSON
    /// syntax,
    /// formatted as a string. It identifies the matchmaking configuration used to
    /// create the
    /// match, and contains data on all players assigned to the match, including
    /// player
    /// attributes and team assignments. For more details on matchmaker data, see
    /// [Match
    /// Data](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-server.html#match-server-data).
    matchmaker_data: ?[]const u8 = null,

    /// The maximum number of players that can be connected simultaneously to the
    /// game session.
    maximum_player_session_count: ?i32 = null,

    /// A collection of information on player sessions created in response to the
    /// game session
    /// placement request. These player sessions are created only after a new game
    /// session is
    /// successfully placed (placement status is `FULFILLED`). This information
    /// includes the player ID, provided in the placement request, and a
    /// corresponding player
    /// session ID.
    placed_player_sessions: ?[]const PlacedPlayerSession = null,

    /// A unique identifier for a game session placement.
    placement_id: ?[]const u8 = null,

    /// The current status of player gateway for the game session placement. Note,
    /// even if a fleet has PlayerGatewayMode configured as `ENABLED`, player
    /// gateway might not be available in a specific location. For more information
    /// about locations where player gateway is supported, see [Amazon GameLift
    /// Servers service
    /// locations](https://docs.aws.amazon.com/gameliftservers/latest/developerguide/gamelift-regions.html).
    ///
    /// Possible values include:
    ///
    /// * `ENABLED` -- Player gateway is available for this game session placement.
    ///
    /// * `DISABLED` -- Player gateway is not available for this game session
    ///   placement.
    player_gateway_status: ?PlayerGatewayStatus = null,

    /// A set of values, expressed in milliseconds, that indicates the amount of
    /// latency that a player experiences when connected to Amazon Web Services
    /// Regions.
    player_latencies: ?[]const PlayerLatency = null,

    /// The port number for the game session. To connect to a Amazon GameLift
    /// Servers game server, an app needs both the IP address and port number. This
    /// value isn't final until placement status is
    /// `FULFILLED`.
    port: ?i32 = null,

    /// An alternative priority list of locations that's included with a game
    /// session
    /// placement request. When provided, the list overrides a queue's location
    /// order list for
    /// this game session placement request only. The list might include Amazon Web
    /// Services Regions, local
    /// zones, and custom locations (for Anywhere fleets). The fallback strategy
    /// tells Amazon GameLift Servers
    /// what action to take (if any) in the event that it failed to place a new game
    /// session.
    priority_configuration_override: ?PriorityConfigurationOverride = null,

    /// Time stamp indicating when this request was placed in the queue. Format is a
    /// number expressed in Unix time as milliseconds (for example
    /// `"1469498468.057"`).
    start_time: ?i64 = null,

    /// Current status of the game session placement request.
    ///
    /// * **PENDING** -- The placement request is
    /// in the queue waiting to be processed. Game session properties are not
    /// yet final.
    ///
    /// * **FULFILLED** -- A new game session has been
    /// successfully placed. Game session properties are now final.
    ///
    /// * **CANCELLED** -- The placement request was
    /// canceled.
    ///
    /// * **TIMED_OUT** -- A new game session was not
    /// successfully created before the time limit expired. You can resubmit the
    /// placement request as needed.
    ///
    /// * **FAILED** -- Amazon GameLift Servers is not able to complete the
    /// process of placing the game session. Common reasons are the game session
    /// terminated before the placement process was completed, or an unexpected
    /// internal
    /// error.
    status: ?GameSessionPlacementState = null,

    pub const json_field_names = .{
        .dns_name = "DnsName",
        .end_time = "EndTime",
        .game_properties = "GameProperties",
        .game_session_arn = "GameSessionArn",
        .game_session_data = "GameSessionData",
        .game_session_id = "GameSessionId",
        .game_session_name = "GameSessionName",
        .game_session_queue_name = "GameSessionQueueName",
        .game_session_region = "GameSessionRegion",
        .ip_address = "IpAddress",
        .matchmaker_data = "MatchmakerData",
        .maximum_player_session_count = "MaximumPlayerSessionCount",
        .placed_player_sessions = "PlacedPlayerSessions",
        .placement_id = "PlacementId",
        .player_gateway_status = "PlayerGatewayStatus",
        .player_latencies = "PlayerLatencies",
        .port = "Port",
        .priority_configuration_override = "PriorityConfigurationOverride",
        .start_time = "StartTime",
        .status = "Status",
    };
};
