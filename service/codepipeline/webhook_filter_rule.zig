/// The event criteria that specify when a webhook notification is sent to your
/// URL.
pub const WebhookFilterRule = struct {
    /// A JsonPath expression that is applied to the body/payload of the webhook.
    /// The value
    /// selected by the JsonPath expression must match the value specified in the
    /// `MatchEquals` field. Otherwise, the request is ignored. For more
    /// information, see [Java JsonPath
    /// implementation](https://github.com/json-path/JsonPath) in GitHub.
    json_path: []const u8,

    /// The value selected by the `JsonPath` expression must match what is
    /// supplied in the `MatchEquals` field. Otherwise, the request is ignored.
    /// Properties from the target action configuration can be included as
    /// placeholders in this
    /// value by surrounding the action configuration key with curly brackets. For
    /// example, if
    /// the value supplied here is "refs/heads/{Branch}" and the target action has
    /// an action
    /// configuration property called "Branch" with a value of "main", the
    /// `MatchEquals` value is evaluated as "refs/heads/main". For a list of
    /// action configuration properties for built-in action types, see [Pipeline
    /// Structure Reference Action
    /// Requirements](https://docs.aws.amazon.com/codepipeline/latest/userguide/reference-pipeline-structure.html#action-requirements).
    match_equals: ?[]const u8 = null,

    pub const json_field_names = .{
        .json_path = "jsonPath",
        .match_equals = "matchEquals",
    };
};
