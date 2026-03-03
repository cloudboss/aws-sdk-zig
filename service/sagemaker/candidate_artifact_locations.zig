/// The location of artifacts for an AutoML candidate job.
pub const CandidateArtifactLocations = struct {
    /// The Amazon S3 prefix to the accuracy metrics and the inference results
    /// observed over the testing window. Available only for the time-series
    /// forecasting problem type.
    backtest_results: ?[]const u8 = null,

    /// The Amazon S3 prefix to the explainability artifacts generated for the
    /// AutoML candidate.
    explainability: []const u8,

    /// The Amazon S3 prefix to the model insight artifacts generated for the AutoML
    /// candidate.
    model_insights: ?[]const u8 = null,

    pub const json_field_names = .{
        .backtest_results = "BacktestResults",
        .explainability = "Explainability",
        .model_insights = "ModelInsights",
    };
};
