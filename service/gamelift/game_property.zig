/// This key-value pair can store custom data about a game session. For example,
/// you might
/// use a `GameProperty` to track a game session's map, level of difficulty, or
/// remaining time. The difficulty level could be specified like this: `{"Key":
/// "difficulty", "Value":"Novice"}`.
///
/// You can set game properties when creating a game session. You can also
/// modify game
/// properties of an active game session. When searching for game sessions, you
/// can filter
/// on game property keys and values. You can't delete game properties from a
/// game session.
///
/// For examples of working with game properties, see [Create a game session
/// with
/// properties](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-sdk-client-api.html#game-properties).
pub const GameProperty = struct {
    /// The game property identifier.
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
    key: []const u8,

    /// The game property value.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
