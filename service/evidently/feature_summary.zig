const aws = @import("aws");

const EvaluationRule = @import("evaluation_rule.zig").EvaluationRule;
const FeatureEvaluationStrategy = @import("feature_evaluation_strategy.zig").FeatureEvaluationStrategy;
const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// This structure contains information about one Evidently feature in your
/// account.
pub const FeatureSummary = struct {
    /// The ARN of the feature.
    arn: []const u8,

    /// The date and time that the feature is created.
    created_time: i64,

    /// The name of the variation that is used as the default variation. The default
    /// variation is served to users who are not allocated to any ongoing launches
    /// or experiments of this feature.
    default_variation: ?[]const u8 = null,

    /// An array of structures that define
    evaluation_rules: ?[]const EvaluationRule = null,

    /// If this value is `ALL_RULES`, the traffic allocation specified by any
    /// ongoing launches or experiments is being used. If this is
    /// `DEFAULT_VARIATION`, the default variation is being served to all users.
    evaluation_strategy: FeatureEvaluationStrategy,

    /// The date and time that the feature was most recently updated.
    last_updated_time: i64,

    /// The name of the feature.
    name: []const u8,

    /// The name or ARN of the project that contains the feature.
    project: ?[]const u8 = null,

    /// The current state of the feature.
    status: FeatureStatus,

    /// The list of tag keys and values associated with this feature.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_time = "createdTime",
        .default_variation = "defaultVariation",
        .evaluation_rules = "evaluationRules",
        .evaluation_strategy = "evaluationStrategy",
        .last_updated_time = "lastUpdatedTime",
        .name = "name",
        .project = "project",
        .status = "status",
        .tags = "tags",
    };
};
