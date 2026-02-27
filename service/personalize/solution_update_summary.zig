const SolutionUpdateConfig = @import("solution_update_config.zig").SolutionUpdateConfig;

/// Provides a summary of the properties of a solution update. For a complete
/// listing, call the
/// [DescribeSolution](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeSolution.html) API.
pub const SolutionUpdateSummary = struct {
    /// The date and time (in Unix format) that the solution update was created.
    creation_date_time: ?i64,

    /// If a solution update fails, the reason behind the failure.
    failure_reason: ?[]const u8,

    /// The date and time (in Unix time) that the solution update was last updated.
    last_updated_date_time: ?i64,

    /// Whether the solution automatically creates solution versions.
    perform_auto_training: ?bool,

    /// A Boolean value that indicates whether incremental training updates are
    /// performed on the model. When enabled, this allows the model to learn from
    /// new data more frequently without requiring full retraining, which enables
    /// near real-time personalization. This parameter is supported only for
    /// solutions that use the semantic-similarity recipe.
    perform_incremental_update: ?bool,

    /// The configuration details of the solution.
    solution_update_config: ?SolutionUpdateConfig,

    /// The status of the solution update. A solution update can be in one of the
    /// following states:
    ///
    /// CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE FAILED
    status: ?[]const u8,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .failure_reason = "failureReason",
        .last_updated_date_time = "lastUpdatedDateTime",
        .perform_auto_training = "performAutoTraining",
        .perform_incremental_update = "performIncrementalUpdate",
        .solution_update_config = "solutionUpdateConfig",
        .status = "status",
    };
};
