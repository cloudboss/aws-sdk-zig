const aws = @import("aws");

const EvaluationRule = @import("evaluation_rule.zig").EvaluationRule;
const FeatureEvaluationStrategy = @import("feature_evaluation_strategy.zig").FeatureEvaluationStrategy;
const FeatureStatus = @import("feature_status.zig").FeatureStatus;
const VariationValueType = @import("variation_value_type.zig").VariationValueType;
const Variation = @import("variation.zig").Variation;

/// This structure contains information about one Evidently feature in your
/// account.
pub const Feature = struct {
    /// The ARN of the feature.
    arn: []const u8,

    /// The date and time that the feature is created.
    created_time: i64,

    /// The name of the variation that is used as the default variation. The default
    /// variation is served to users who are not allocated to any ongoing launches
    /// or experiments of this feature.
    ///
    /// This variation must also be listed in the `variations` structure.
    ///
    /// If you omit `defaultVariation`, the first variation listed in the
    /// `variations` structure is used as the default variation.
    default_variation: ?[]const u8 = null,

    /// The description of the feature.
    description: ?[]const u8 = null,

    /// A set of key-value pairs that specify users who should always be served a
    /// specific variation of a feature. Each key specifies a user using their user
    /// ID, account ID, or some other identifier. The value specifies the name of
    /// the variation that the user is to be served.
    ///
    /// For the override to be successful, the value of the key must match the
    /// `entityId` used in the
    /// [EvaluateFeature](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_EvaluateFeature.html) operation.
    entity_overrides: ?[]const aws.map.StringMapEntry = null,

    /// An array of structures that define the evaluation rules for the feature.
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

    /// Defines the type of value used to define the different feature variations.
    /// For more information, see [Variation
    /// types](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Evidently-variationtypes.html)
    value_type: VariationValueType,

    /// An array of structures that contain the configuration of the feature's
    /// different variations.
    variations: []const Variation,

    pub const json_field_names = .{
        .arn = "arn",
        .created_time = "createdTime",
        .default_variation = "defaultVariation",
        .description = "description",
        .entity_overrides = "entityOverrides",
        .evaluation_rules = "evaluationRules",
        .evaluation_strategy = "evaluationStrategy",
        .last_updated_time = "lastUpdatedTime",
        .name = "name",
        .project = "project",
        .status = "status",
        .tags = "tags",
        .value_type = "valueType",
        .variations = "variations",
    };
};
