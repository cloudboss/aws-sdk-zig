/// In a model evaluation job that uses human workers you must define the name
/// of the metric, and how you want that metric rated `ratingMethod`, and an
/// optional description of the metric.
pub const HumanEvaluationCustomMetric = struct {
    /// An optional description of the metric. Use this parameter to provide more
    /// details about the metric.
    description: ?[]const u8 = null,

    /// The name of the metric. Your human evaluators will see this name in the
    /// evaluation UI.
    name: []const u8,

    /// Choose how you want your human workers to evaluation your model. Valid
    /// values for rating methods are `ThumbsUpDown`,
    /// `IndividualLikertScale`,`ComparisonLikertScale`, `ComparisonChoice`, and
    /// `ComparisonRank`
    rating_method: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .rating_method = "ratingMethod",
    };
};
