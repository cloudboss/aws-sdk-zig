/// Specifies the prediction (aka, the automatically generated piece of
/// metadata) and the target (for example, a column name) that can be accepted.
pub const AcceptChoice = struct {
    /// The edit of the prediction.
    edited_value: ?[]const u8,

    /// Specifies the prediction (aka, the automatically generated piece of
    /// metadata) that can be accepted.
    prediction_choice: ?i32,

    /// Specifies the target (for example, a column name) where a prediction can be
    /// accepted.
    prediction_target: []const u8,

    pub const json_field_names = .{
        .edited_value = "editedValue",
        .prediction_choice = "predictionChoice",
        .prediction_target = "predictionTarget",
    };
};
