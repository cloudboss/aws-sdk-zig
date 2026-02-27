/// The details of the automatically generated business metadata that is
/// rejected.
pub const RejectChoice = struct {
    /// Specifies the the automatically generated business metadata that can be
    /// rejected.
    prediction_choices: ?[]const i32,

    /// Specifies the target (for example, a column name) where a prediction can be
    /// rejected.
    prediction_target: []const u8,

    pub const json_field_names = .{
        .prediction_choices = "predictionChoices",
        .prediction_target = "predictionTarget",
    };
};
