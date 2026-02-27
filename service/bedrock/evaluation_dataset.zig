const EvaluationDatasetLocation = @import("evaluation_dataset_location.zig").EvaluationDatasetLocation;

/// Used to specify the name of a built-in prompt dataset and optionally, the
/// Amazon S3 bucket where a custom prompt dataset is saved.
pub const EvaluationDataset = struct {
    /// For custom prompt datasets, you must specify the location in Amazon S3 where
    /// the prompt dataset is saved.
    dataset_location: ?EvaluationDatasetLocation,

    /// Used to specify supported built-in prompt datasets. Valid values are
    /// `Builtin.Bold`, `Builtin.BoolQ`, `Builtin.NaturalQuestions`,
    /// `Builtin.Gigaword`, `Builtin.RealToxicityPrompts`, `Builtin.TriviaQA`,
    /// `Builtin.T-Rex`, `Builtin.WomensEcommerceClothingReviews` and
    /// `Builtin.Wikitext2`.
    name: []const u8,

    pub const json_field_names = .{
        .dataset_location = "datasetLocation",
        .name = "name",
    };
};
