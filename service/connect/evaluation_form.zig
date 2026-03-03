const aws = @import("aws");

const EvaluationFormAutoEvaluationConfiguration = @import("evaluation_form_auto_evaluation_configuration.zig").EvaluationFormAutoEvaluationConfiguration;
const EvaluationFormItem = @import("evaluation_form_item.zig").EvaluationFormItem;
const EvaluationFormLanguageConfiguration = @import("evaluation_form_language_configuration.zig").EvaluationFormLanguageConfiguration;
const EvaluationReviewConfiguration = @import("evaluation_review_configuration.zig").EvaluationReviewConfiguration;
const EvaluationFormScoringStrategy = @import("evaluation_form_scoring_strategy.zig").EvaluationFormScoringStrategy;
const EvaluationFormVersionStatus = @import("evaluation_form_version_status.zig").EvaluationFormVersionStatus;
const EvaluationFormTargetConfiguration = @import("evaluation_form_target_configuration.zig").EvaluationFormTargetConfiguration;

/// Information about the evaluation form.
pub const EvaluationForm = struct {
    /// The automatic evaluation configuration of an evaluation form.
    auto_evaluation_configuration: ?EvaluationFormAutoEvaluationConfiguration = null,

    /// The Amazon Resource Name (ARN) of the user who created the evaluation form.
    created_by: []const u8,

    /// The timestamp for when the evaluation form was created.
    created_time: i64,

    /// The description of the evaluation form.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the evaluation form resource.
    evaluation_form_arn: []const u8,

    /// The unique identifier for the evaluation form.
    evaluation_form_id: []const u8,

    /// A version of the evaluation form.
    evaluation_form_version: i32 = 0,

    /// Items that are part of the evaluation form. The total number of sections and
    /// questions must not exceed 100 each. Questions must be contained in a
    /// section.
    items: []const EvaluationFormItem,

    /// Configuration for language settings of this evaluation form.
    language_configuration: ?EvaluationFormLanguageConfiguration = null,

    /// The Amazon Resource Name (ARN) of the user who last updated the evaluation
    /// form.
    last_modified_by: []const u8,

    /// The timestamp for when the evaluation form was last updated.
    last_modified_time: i64,

    /// The flag indicating whether the evaluation form is locked for changes.
    locked: bool = false,

    /// Configuration for evaluation review settings of this evaluation form.
    review_configuration: ?EvaluationReviewConfiguration = null,

    /// A scoring strategy of the evaluation form.
    scoring_strategy: ?EvaluationFormScoringStrategy = null,

    /// The status of the evaluation form.
    status: EvaluationFormVersionStatus,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Configuration that specifies the target for this evaluation form.
    target_configuration: ?EvaluationFormTargetConfiguration = null,

    /// A title of the evaluation form.
    title: []const u8,

    pub const json_field_names = .{
        .auto_evaluation_configuration = "AutoEvaluationConfiguration",
        .created_by = "CreatedBy",
        .created_time = "CreatedTime",
        .description = "Description",
        .evaluation_form_arn = "EvaluationFormArn",
        .evaluation_form_id = "EvaluationFormId",
        .evaluation_form_version = "EvaluationFormVersion",
        .items = "Items",
        .language_configuration = "LanguageConfiguration",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .locked = "Locked",
        .review_configuration = "ReviewConfiguration",
        .scoring_strategy = "ScoringStrategy",
        .status = "Status",
        .tags = "Tags",
        .target_configuration = "TargetConfiguration",
        .title = "Title",
    };
};
