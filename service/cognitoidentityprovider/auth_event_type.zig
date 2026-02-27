const ChallengeResponseType = @import("challenge_response_type.zig").ChallengeResponseType;
const EventContextDataType = @import("event_context_data_type.zig").EventContextDataType;
const EventFeedbackType = @import("event_feedback_type.zig").EventFeedbackType;
const EventResponseType = @import("event_response_type.zig").EventResponseType;
const EventRiskType = @import("event_risk_type.zig").EventRiskType;
const EventType = @import("event_type.zig").EventType;

/// One authentication event that Amazon Cognito logged in a user pool with
/// threat protection
/// active. Contains user and device metadata and a risk assessment from your
/// user
/// pool.
pub const AuthEventType = struct {
    /// A list of the challenges that the user was requested to answer, for example
    /// `Password`, and the result, for example `Success`.
    challenge_responses: ?[]const ChallengeResponseType,

    /// The date and time when the item was created. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    creation_date: ?i64,

    /// The user context data captured at the time of an event request. This value
    /// provides
    /// additional information about the client from which event the request is
    /// received.
    event_context_data: ?EventContextDataType,

    /// The `UpdateAuthEventFeedback` or `AdminUpdateAuthEventFeedback`
    /// feedback that you or your user provided in response to the event. A value of
    /// `Valid` indicates that you disagreed with the level of risk that your
    /// user pool assigned, and evaluated a session to be valid, or likely safe. A
    /// value of
    /// `Invalid` indicates that you agreed with the user pool risk level and
    /// evaluated a session to be invalid, or likely malicious.
    event_feedback: ?EventFeedbackType,

    /// The event ID.
    event_id: ?[]const u8,

    /// The event response.
    event_response: ?EventResponseType,

    /// The threat evaluation from your user pool about an event. Contains
    /// information about
    /// whether your user pool detected compromised credentials, whether the event
    /// triggered an
    /// automated response, and the level of risk.
    event_risk: ?EventRiskType,

    /// The type of authentication event.
    event_type: ?EventType,

    pub const json_field_names = .{
        .challenge_responses = "ChallengeResponses",
        .creation_date = "CreationDate",
        .event_context_data = "EventContextData",
        .event_feedback = "EventFeedback",
        .event_id = "EventId",
        .event_response = "EventResponse",
        .event_risk = "EventRisk",
        .event_type = "EventType",
    };
};
