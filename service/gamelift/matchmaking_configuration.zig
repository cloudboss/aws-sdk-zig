const BackfillMode = @import("backfill_mode.zig").BackfillMode;
const FlexMatchMode = @import("flex_match_mode.zig").FlexMatchMode;
const GameProperty = @import("game_property.zig").GameProperty;

/// Guidelines for use with FlexMatch to match players into games. All
/// matchmaking requests
/// must specify a matchmaking configuration.
pub const MatchmakingConfiguration = struct {
    /// A flag that indicates whether a match that was created with this
    /// configuration must be
    /// accepted by the matched players. To require acceptance, set to TRUE. When
    /// this option is
    /// enabled, matchmaking tickets use the status `REQUIRES_ACCEPTANCE` to
    /// indicate
    /// when a completed potential match is waiting for player acceptance.
    acceptance_required: ?bool,

    /// The length of time (in seconds) to wait for players to accept a proposed
    /// match, if
    /// acceptance is required. If any player rejects the match or fails to accept
    /// before the
    /// timeout, the ticket continues to look for an acceptable match.
    acceptance_timeout_seconds: ?i32,

    /// The number of player slots in a match to keep open for future players. For
    /// example, if the configuration's rule set specifies
    /// a match for a single 12-person team, and the additional player count is set
    /// to 2, only 10 players are selected for the match. This parameter is not used
    /// when `FlexMatchMode` is set to
    /// `STANDALONE`.
    additional_player_count: ?i32,

    /// The method used to backfill game sessions created with this matchmaking
    /// configuration.
    /// MANUAL indicates that the game makes backfill requests or does not use the
    /// match
    /// backfill feature. AUTOMATIC indicates that GameLift creates backfill
    /// requests whenever a
    /// game session has one or more open slots. Learn more about manual and
    /// automatic backfill
    /// in [Backfill existing games with
    /// FlexMatch](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-backfill.html). Automatic backfill is not available
    /// when `FlexMatchMode` is set to `STANDALONE`.
    backfill_mode: ?BackfillMode,

    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that is assigned to a Amazon GameLift Servers matchmaking configuration
    /// resource and uniquely identifies it. ARNs are unique across all Regions.
    /// Format is `arn:aws:gamelift:::matchmakingconfiguration/`. In a Amazon
    /// GameLift Servers configuration ARN, the resource ID matches the
    /// *Name* value.
    configuration_arn: ?[]const u8,

    /// A time stamp indicating when this data object was created. Format is a
    /// number expressed in Unix time as milliseconds (for example
    /// `"1469498468.057"`).
    creation_time: ?i64,

    /// Information to attach to all events related to the matchmaking
    /// configuration.
    custom_event_data: ?[]const u8,

    /// A descriptive label that is associated with matchmaking configuration.
    description: ?[]const u8,

    /// Indicates whether this matchmaking configuration is being used with Amazon
    /// GameLift Servers hosting or
    /// as a standalone matchmaking solution.
    ///
    /// * **STANDALONE** - FlexMatch forms matches and
    /// returns match information, including players and team assignments, in a [
    /// MatchmakingSucceeded](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-events.html#match-events-matchmakingsucceeded) event.
    ///
    /// * **WITH_QUEUE** - FlexMatch forms matches and uses
    /// the specified Amazon GameLift Servers queue to start a game session for the
    /// match.
    flex_match_mode: ?FlexMatchMode,

    /// A set of key-value pairs that can store custom data in a game session.
    /// For example: `{"Key": "difficulty", "Value": "novice"}`. This information is
    /// added to the new `GameSession` object that is
    /// created for a successful match. This parameter is not used when
    /// `FlexMatchMode` is set to `STANDALONE`.
    ///
    /// Avoid using periods (".") in property keys if you plan to search for game
    /// sessions by properties. Property keys containing periods cannot be searched
    /// and will be filtered out from search results due to search index
    /// limitations.
    game_properties: ?[]const GameProperty,

    /// A set of custom game session properties, formatted as a single string value.
    /// This data is passed to a game server process with a request to start a new
    /// game session. For more information, see [Start a game
    /// session](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-sdk-server-api.html#gamelift-sdk-server-startsession). This information is added to the new `GameSession` object that is
    /// created for a successful match. This parameter is not used when
    /// `FlexMatchMode` is set to `STANDALONE`.
    game_session_data: ?[]const u8,

    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that is assigned to a Amazon GameLift Servers game session queue resource
    /// and uniquely identifies it. ARNs are unique across all Regions. Format is
    /// `arn:aws:gamelift:::gamesessionqueue/`. Queues can be located in any Region.
    /// Queues are used to start new
    /// Amazon GameLift Servers-hosted game sessions for matches that are created
    /// with this matchmaking
    /// configuration. This property is not set when `FlexMatchMode` is set to
    /// `STANDALONE`.
    game_session_queue_arns: ?[]const []const u8,

    /// A unique identifier for the matchmaking configuration. This name is used to
    /// identify the configuration associated with a matchmaking
    /// request or ticket.
    name: ?[]const u8,

    /// An SNS topic ARN that is set up to receive matchmaking notifications.
    notification_target: ?[]const u8,

    /// The maximum duration, in seconds, that a matchmaking ticket can remain in
    /// process
    /// before timing out. Requests that fail due to timing out can be resubmitted
    /// as
    /// needed.
    request_timeout_seconds: ?i32,

    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// associated with the GameLift matchmaking rule set resource that this
    /// configuration uses.
    rule_set_arn: ?[]const u8,

    /// A unique identifier for the matchmaking rule set to use with this
    /// configuration. A matchmaking configuration can only use rule
    /// sets that are defined in the same Region.
    rule_set_name: ?[]const u8,

    pub const json_field_names = .{
        .acceptance_required = "AcceptanceRequired",
        .acceptance_timeout_seconds = "AcceptanceTimeoutSeconds",
        .additional_player_count = "AdditionalPlayerCount",
        .backfill_mode = "BackfillMode",
        .configuration_arn = "ConfigurationArn",
        .creation_time = "CreationTime",
        .custom_event_data = "CustomEventData",
        .description = "Description",
        .flex_match_mode = "FlexMatchMode",
        .game_properties = "GameProperties",
        .game_session_data = "GameSessionData",
        .game_session_queue_arns = "GameSessionQueueArns",
        .name = "Name",
        .notification_target = "NotificationTarget",
        .request_timeout_seconds = "RequestTimeoutSeconds",
        .rule_set_arn = "RuleSetArn",
        .rule_set_name = "RuleSetName",
    };
};
