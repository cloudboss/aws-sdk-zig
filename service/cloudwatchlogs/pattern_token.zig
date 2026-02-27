const aws = @import("aws");

/// A structure that contains information about one pattern token related to an
/// anomaly.
///
/// For more information about patterns and tokens, see
/// [CreateLogAnomalyDetector](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_CreateLogAnomalyDetector.html).
pub const PatternToken = struct {
    /// For a dynamic token, this indicates where in the pattern that this token
    /// appears, related
    /// to other dynamic tokens. The dynamic token that appears first has a value of
    /// `1`,
    /// the one that appears second is `2`, and so on.
    dynamic_token_position: i32 = 0,

    /// Contains the values found for a dynamic token, and the number of times each
    /// value was
    /// found.
    enumerations: ?[]const aws.map.MapEntry(i64),

    /// A name that CloudWatch Logs assigned to this dynamic token to make the
    /// pattern more
    /// readable. The string part of the `inferredTokenName` gives you a clearer
    /// idea of
    /// the content of this token. The number part of the `inferredTokenName` shows
    /// where
    /// in the pattern this token appears, compared to other dynamic tokens.
    /// CloudWatch Logs
    /// assigns the string part of the name based on analyzing the content of the
    /// log events that
    /// contain it.
    ///
    /// For example, an inferred token name of `IPAddress-3` means that the token
    /// represents an IP address, and this token is the third dynamic token in the
    /// pattern.
    inferred_token_name: ?[]const u8,

    /// Specifies whether this is a dynamic token.
    is_dynamic: ?bool,

    /// The string represented by this token. If this is a dynamic token, the value
    /// will be
    /// ``
    token_string: ?[]const u8,

    pub const json_field_names = .{
        .dynamic_token_position = "dynamicTokenPosition",
        .enumerations = "enumerations",
        .inferred_token_name = "inferredTokenName",
        .is_dynamic = "isDynamic",
        .token_string = "tokenString",
    };
};
