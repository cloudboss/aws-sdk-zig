/// Summary information about an evaluation form.
pub const EvaluationFormSummary = struct {
    /// The version of the active evaluation form version.
    active_version: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the user who created the evaluation form.
    created_by: []const u8,

    /// The timestamp for when the evaluation form was created.
    created_time: i64,

    /// The Amazon Resource Name (ARN) for the evaluation form resource.
    evaluation_form_arn: []const u8,

    /// The unique identifier for the evaluation form.
    evaluation_form_id: []const u8,

    /// The Amazon Resource Name (ARN) of the user who last activated the evaluation
    /// form.
    last_activated_by: ?[]const u8 = null,

    /// The timestamp for when the evaluation form was last activated.
    last_activated_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the user who last updated the evaluation
    /// form.
    last_modified_by: []const u8,

    /// The timestamp for when the evaluation form was last updated.
    last_modified_time: i64,

    /// The version number of the latest evaluation form version.
    latest_version: i32 = 0,

    /// A title of the evaluation form.
    title: []const u8,

    pub const json_field_names = .{
        .active_version = "ActiveVersion",
        .created_by = "CreatedBy",
        .created_time = "CreatedTime",
        .evaluation_form_arn = "EvaluationFormArn",
        .evaluation_form_id = "EvaluationFormId",
        .last_activated_by = "LastActivatedBy",
        .last_activated_time = "LastActivatedTime",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .latest_version = "LatestVersion",
        .title = "Title",
    };
};
