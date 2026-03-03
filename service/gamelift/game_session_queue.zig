const GameSessionQueueDestination = @import("game_session_queue_destination.zig").GameSessionQueueDestination;
const FilterConfiguration = @import("filter_configuration.zig").FilterConfiguration;
const PlayerLatencyPolicy = @import("player_latency_policy.zig").PlayerLatencyPolicy;
const PriorityConfiguration = @import("priority_configuration.zig").PriorityConfiguration;

/// Configuration for a game session placement mechanism that processes requests
/// for new
/// game sessions. A queue can be used on its own or as part of a matchmaking
/// solution.
pub const GameSessionQueue = struct {
    /// Information that is added to all events that are related to this game
    /// session
    /// queue.
    custom_event_data: ?[]const u8 = null,

    /// A list of fleets and/or fleet aliases that can be used to fulfill game
    /// session placement requests in the queue.
    /// Destinations are identified by either a fleet ARN or a fleet alias ARN, and
    /// are listed in order of placement preference.
    destinations: ?[]const GameSessionQueueDestination = null,

    /// A list of locations where a queue is allowed to place new game sessions.
    /// Locations
    /// are specified in the form of Amazon Web Services Region codes, such as
    /// `us-west-2`. If this parameter is
    /// not set, game sessions can be placed in any queue location.
    filter_configuration: ?FilterConfiguration = null,

    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that is assigned to a Amazon GameLift Servers game session queue resource
    /// and uniquely identifies it. ARNs are unique across all Regions. Format is
    /// `arn:aws:gamelift:::gamesessionqueue/`. In a Amazon GameLift Servers game
    /// session queue ARN, the resource ID matches the
    /// *Name* value.
    game_session_queue_arn: ?[]const u8 = null,

    /// A descriptive label that is associated with game session queue. Queue names
    /// must be unique within each Region.
    name: ?[]const u8 = null,

    /// An SNS topic ARN that is set up to receive game session placement
    /// notifications. See
    /// [ Setting up
    /// notifications for game session
    /// placement](https://docs.aws.amazon.com/gamelift/latest/developerguide/queue-notification.html).
    notification_target: ?[]const u8 = null,

    /// A set of policies that enforce a sliding cap on player latency when
    /// processing game sessions placement requests.
    /// Use multiple policies to gradually relax the cap over time if Amazon
    /// GameLift Servers can't make a placement.
    /// Policies are evaluated in order starting with the lowest maximum latency
    /// value.
    player_latency_policies: ?[]const PlayerLatencyPolicy = null,

    /// Custom settings to use when prioritizing destinations and locations for game
    /// session placements. This
    /// configuration replaces the FleetIQ default prioritization process. Priority
    /// types that are not explicitly
    /// named will be automatically applied at the end of the prioritization
    /// process.
    priority_configuration: ?PriorityConfiguration = null,

    /// The maximum time, in seconds, that a new game session placement request
    /// remains in the queue. When a request exceeds this time, the game session
    /// placement changes to a `TIMED_OUT` status.
    ///
    /// The minimum value is 10 and the maximum value is 600.
    timeout_in_seconds: ?i32 = null,

    pub const json_field_names = .{
        .custom_event_data = "CustomEventData",
        .destinations = "Destinations",
        .filter_configuration = "FilterConfiguration",
        .game_session_queue_arn = "GameSessionQueueArn",
        .name = "Name",
        .notification_target = "NotificationTarget",
        .player_latency_policies = "PlayerLatencyPolicies",
        .priority_configuration = "PriorityConfiguration",
        .timeout_in_seconds = "TimeoutInSeconds",
    };
};
