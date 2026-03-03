const aws = @import("aws");

/// Describes the result of the evaluation of a data quality analyzer.
pub const DataQualityAnalyzerResult = struct {
    /// A description of the data quality analyzer.
    description: ?[]const u8 = null,

    /// A map of metrics associated with the evaluation of the analyzer.
    evaluated_metrics: ?[]const aws.map.MapEntry(f64) = null,

    /// An evaluation message.
    evaluation_message: ?[]const u8 = null,

    /// The name of the data quality analyzer.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .evaluated_metrics = "EvaluatedMetrics",
        .evaluation_message = "EvaluationMessage",
        .name = "Name",
    };
};
