const aws = @import("aws");

const StatisticEvaluationLevel = @import("statistic_evaluation_level.zig").StatisticEvaluationLevel;
const TimestampedInclusionAnnotation = @import("timestamped_inclusion_annotation.zig").TimestampedInclusionAnnotation;
const RunIdentifier = @import("run_identifier.zig").RunIdentifier;

/// Summary information about a statistic.
pub const StatisticSummary = struct {
    /// The list of columns referenced by the statistic.
    columns_referenced: ?[]const []const u8,

    /// The value of the statistic.
    double_value: f64 = 0,

    /// The evaluation level of the statistic. Possible values: `Dataset`, `Column`,
    /// `Multicolumn`.
    evaluation_level: ?StatisticEvaluationLevel,

    /// The inclusion annotation for the statistic.
    inclusion_annotation: ?TimestampedInclusionAnnotation,

    /// The Profile ID.
    profile_id: ?[]const u8,

    /// The timestamp when the statistic was recorded.
    recorded_on: ?i64,

    /// The list of datasets referenced by the statistic.
    referenced_datasets: ?[]const []const u8,

    /// The Run Identifier
    run_identifier: ?RunIdentifier,

    /// The Statistic ID.
    statistic_id: ?[]const u8,

    /// The name of the statistic.
    statistic_name: ?[]const u8,

    /// A `StatisticPropertiesMap`, which contains a `NameString` and
    /// `DescriptionString`
    statistic_properties: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .columns_referenced = "ColumnsReferenced",
        .double_value = "DoubleValue",
        .evaluation_level = "EvaluationLevel",
        .inclusion_annotation = "InclusionAnnotation",
        .profile_id = "ProfileId",
        .recorded_on = "RecordedOn",
        .referenced_datasets = "ReferencedDatasets",
        .run_identifier = "RunIdentifier",
        .statistic_id = "StatisticId",
        .statistic_name = "StatisticName",
        .statistic_properties = "StatisticProperties",
    };
};
