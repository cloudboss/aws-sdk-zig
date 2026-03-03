const GameSessionConnectionInfo = @import("game_session_connection_info.zig").GameSessionConnectionInfo;
const Player = @import("player.zig").Player;
const MatchmakingConfigurationStatus = @import("matchmaking_configuration_status.zig").MatchmakingConfigurationStatus;

/// Ticket generated to track the progress of a matchmaking request. Each ticket
/// is
/// uniquely identified by a ticket ID, supplied by the requester, when creating
/// a
/// matchmaking request.
pub const MatchmakingTicket = struct {
    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// associated with the GameLift matchmaking configuration resource that is used
    /// with this ticket.
    configuration_arn: ?[]const u8 = null,

    /// Name of the matchmaking configuration that is used with this ticket.
    /// Matchmaking
    /// configurations determine how players are grouped into a match and how a new
    /// game session
    /// is created for the match.
    configuration_name: ?[]const u8 = null,

    /// Time stamp indicating when the matchmaking request stopped being processed
    /// due to
    /// successful completion, timeout, or cancellation. Format is a number
    /// expressed in Unix time as milliseconds (for example `"1469498468.057"`).
    end_time: ?i64 = null,

    /// Average amount of time (in seconds) that players are currently waiting for a
    /// match. If
    /// there is not enough recent data, this property may be empty.
    estimated_wait_time: ?i32 = null,

    /// Connection information for a new game session. Once a match is made, the
    /// FlexMatch
    /// engine creates a new game session for it. This information is added to the
    /// matchmaking
    /// ticket, which you can be retrieve by calling
    /// [DescribeMatchmaking](https://docs.aws.amazon.com/gamelift/latest/apireference/API_DescribeMatchmaking.html) .
    game_session_connection_info: ?GameSessionConnectionInfo = null,

    /// A set of `Player` objects, each representing a player to find matches for.
    /// Players are identified by a unique player ID and may include latency data
    /// for use during
    /// matchmaking. If the ticket is in status `COMPLETED`, the `Player`
    /// objects include the team the players were assigned to in the resulting
    /// match.
    players: ?[]const Player = null,

    /// Time stamp indicating when this matchmaking request was received. Format is
    /// a number expressed in Unix time as milliseconds (for example
    /// `"1469498468.057"`).
    start_time: ?i64 = null,

    /// Current status of the matchmaking request.
    ///
    /// * **QUEUED** -- The matchmaking request has been
    /// received and is currently waiting to be processed.
    ///
    /// * **SEARCHING** -- The matchmaking request is
    /// currently being processed.
    ///
    /// * **REQUIRES_ACCEPTANCE** -- A match has been
    /// proposed and the players must accept the match. This status is used only
    /// with
    /// requests that use a matchmaking configuration with a player acceptance
    /// requirement.
    ///
    /// * **PLACING** -- The FlexMatch engine has matched
    /// players and is in the process of placing a new game session for the
    /// match.
    ///
    /// * **COMPLETED** -- Players have been matched and a
    /// game session is ready to host the players. A ticket in this state contains
    /// the
    /// necessary connection information for players.
    ///
    /// * **FAILED** -- The matchmaking request was not
    /// completed.
    ///
    /// * **CANCELLED** -- The matchmaking request was
    /// canceled. This may be the result of a `StopMatchmaking` operation or
    /// a proposed match that one or more players failed to accept.
    ///
    /// * **TIMED_OUT** -- The matchmaking request was not
    /// successful within the duration specified in the matchmaking configuration.
    ///
    /// Matchmaking requests that fail to successfully complete (statuses FAILED,
    /// CANCELLED, TIMED_OUT) can be resubmitted as new requests with new ticket
    /// IDs.
    status: ?MatchmakingConfigurationStatus = null,

    /// Additional information about the current status.
    status_message: ?[]const u8 = null,

    /// Code to explain the current status. For example, a status reason may
    /// indicate when a
    /// ticket has returned to `SEARCHING` status after a proposed match fails to
    /// receive player acceptances.
    status_reason: ?[]const u8 = null,

    /// A unique identifier for a matchmaking ticket.
    ticket_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_arn = "ConfigurationArn",
        .configuration_name = "ConfigurationName",
        .end_time = "EndTime",
        .estimated_wait_time = "EstimatedWaitTime",
        .game_session_connection_info = "GameSessionConnectionInfo",
        .players = "Players",
        .start_time = "StartTime",
        .status = "Status",
        .status_message = "StatusMessage",
        .status_reason = "StatusReason",
        .ticket_id = "TicketId",
    };
};
