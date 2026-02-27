const aws = @import("aws");

const ContactInteractionType = @import("contact_interaction_type.zig").ContactInteractionType;
const EvaluationFormLanguageCode = @import("evaluation_form_language_code.zig").EvaluationFormLanguageCode;
const EvaluationFormVersionStatus = @import("evaluation_form_version_status.zig").EvaluationFormVersionStatus;

/// Information about the returned evaluation forms.
pub const EvaluationFormSearchSummary = struct {
    /// Active version of the evaluation form.
    active_version: ?i32,

    /// Whether automated evaluation is enabled.
    auto_evaluation_enabled: bool = false,

    /// The contact interaction type for this evaluation form.
    contact_interaction_type: ?ContactInteractionType,

    /// Who created the evaluation form.
    created_by: []const u8,

    /// When the evaluation form was created.
    created_time: i64,

    /// The description of the evaluation form.
    description: ?[]const u8,

    /// The Amazon Resource Name (ARN) for the evaluation form resource.
    evaluation_form_arn: []const u8,

    /// The unique identifier for the evaluation form.
    evaluation_form_id: []const u8,

    /// The language of the evaluation form.
    evaluation_form_language: ?EvaluationFormLanguageCode,

    /// The ID of user who last activated evaluation form.
    last_activated_by: ?[]const u8,

    /// When the evaluation format was last activated.
    last_activated_time: ?i64,

    /// Who changed the evaluation form.
    last_modified_by: []const u8,

    /// When the evaluation form was last changed.
    last_modified_time: i64,

    /// Latest version of the evaluation form.
    latest_version: i32,

    /// The status of the evaluation form.
    status: EvaluationFormVersionStatus,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry,

    /// The title of the evaluation form.
    title: []const u8,

    pub const json_field_names = .{
        .active_version = "ActiveVersion",
        .auto_evaluation_enabled = "AutoEvaluationEnabled",
        .contact_interaction_type = "ContactInteractionType",
        .created_by = "CreatedBy",
        .created_time = "CreatedTime",
        .description = "Description",
        .evaluation_form_arn = "EvaluationFormArn",
        .evaluation_form_id = "EvaluationFormId",
        .evaluation_form_language = "EvaluationFormLanguage",
        .last_activated_by = "LastActivatedBy",
        .last_activated_time = "LastActivatedTime",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .latest_version = "LatestVersion",
        .status = "Status",
        .tags = "Tags",
        .title = "Title",
    };
};
