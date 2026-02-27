/// An object that identifies an action.
///
/// The API returns a list of
/// `PredictedAction`s.
pub const PredictedAction = struct {
    /// The ID of the recommended action.
    action_id: ?[]const u8,

    /// The score of the recommended action. For information about action scores,
    /// see [How action recommendation scoring
    /// works](https://docs.aws.amazon.com/personalize/latest/dg/how-action-recommendation-scoring-works.html).
    score: ?f64,

    pub const json_field_names = .{
        .action_id = "actionId",
        .score = "score",
    };
};
