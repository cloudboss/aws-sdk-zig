/// Represents an action interaction event sent using the
/// `PutActionInteractions` API.
pub const ActionInteraction = struct {
    /// The ID of the action the user interacted with. This corresponds to the
    /// `ACTION_ID`
    /// field of the Action interaction schema.
    action_id: []const u8,

    /// An ID associated with the event. If an event ID is not provided, Amazon
    /// Personalize generates
    /// a unique ID for the event. An event ID is not used as an input to the model.
    /// Amazon Personalize uses
    /// the event ID to distinguish unique events. Any subsequent events after the
    /// first with the
    /// same event ID are not used in model training.
    event_id: ?[]const u8 = null,

    /// The type of action interaction event. You can specify `Viewed`, `Taken`, and
    /// `Not Taken` event types. For more
    /// information about action interaction event type data, see [Event type
    /// data](https://docs.aws.amazon.com/personalize/latest/dg/action-interaction-event-type-data.html).
    event_type: []const u8,

    /// A list of action IDs that represents the sequence of actions you have shown
    /// the user. For example, `["actionId1", "actionId2", "actionId3"]`.
    /// Amazon Personalize doesn't use impressions data from action interaction
    /// events. Instead, record multiple events for each action and use the `Viewed`
    /// event type.
    impression: ?[]const []const u8 = null,

    /// A string map of event-specific data that you might choose to record. For
    /// example, if a
    /// user takes an action, other than the action ID, you might also send the
    /// number of actions taken by the user.
    ///
    /// Each item in the map consists of a key-value pair. For example,
    ///
    /// `{"numberOfActions": "12"}`
    ///
    /// The keys use camel case names that match the fields in the Action
    /// interactions
    /// schema. In the above example, the `numberOfActions` would match the
    /// 'NUMBER_OF_ACTIONS' field defined in the Action interactions schema.
    ///
    /// The following can't be included as a keyword for properties (case
    /// insensitive).
    ///
    /// * userId
    ///
    /// * sessionId
    ///
    /// * eventType
    ///
    /// * timestamp
    ///
    /// * recommendationId
    ///
    /// * impression
    properties: ?[]const u8 = null,

    /// The ID of the list of recommendations that contains the action the user
    /// interacted with.
    recommendation_id: ?[]const u8 = null,

    /// The ID associated with the user's visit.
    /// Your application generates a unique `sessionId` when a user first visits
    /// your website or uses your application.
    session_id: []const u8,

    /// The timestamp for when the action interaction event occurred. Timestamps
    /// must be in Unix epoch time format, in seconds.
    timestamp: i64,

    /// The ID of the user who interacted with the action. This corresponds to the
    /// `USER_ID`
    /// field of the Action interaction schema.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_id = "actionId",
        .event_id = "eventId",
        .event_type = "eventType",
        .impression = "impression",
        .properties = "properties",
        .recommendation_id = "recommendationId",
        .session_id = "sessionId",
        .timestamp = "timestamp",
        .user_id = "userId",
    };
};
