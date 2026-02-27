/// Specifies configuration options for automatic data quality evaluation in
/// Glue jobs. This structure enables automated data quality
/// checks and monitoring during ETL operations, helping to ensure data
/// integrity and reliability without manual intervention.
pub const AutoDataQuality = struct {
    /// The evaluation context for the automatic data quality checks. This defines
    /// the scope and parameters for the data quality evaluation.
    evaluation_context: ?[]const u8,

    /// Specifies whether automatic data quality evaluation is enabled. When set to
    /// `true`, data quality checks are performed automatically.
    is_enabled: bool = false,

    pub const json_field_names = .{
        .evaluation_context = "EvaluationContext",
        .is_enabled = "IsEnabled",
    };
};
