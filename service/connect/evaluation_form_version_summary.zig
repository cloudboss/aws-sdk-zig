const EvaluationFormVersionStatus = @import("evaluation_form_version_status.zig").EvaluationFormVersionStatus;

/// Summary information about an evaluation form.
pub const EvaluationFormVersionSummary = struct {
    /// The Amazon Resource Name (ARN) of the user who created the evaluation form.
    created_by: []const u8,

    /// The timestamp for when the evaluation form was created.
    created_time: i64,

    /// The Amazon Resource Name (ARN) for the evaluation form resource.
    evaluation_form_arn: []const u8,

    /// The unique identifier for the evaluation form.
    evaluation_form_id: []const u8,

    /// A version of the evaluation form.
    evaluation_form_version: i32 = 0,

    /// The Amazon Resource Name (ARN) of the user who last updated the evaluation
    /// form.
    last_modified_by: []const u8,

    /// The timestamp for when the evaluation form was last updated.
    last_modified_time: i64,

    /// The flag indicating whether the evaluation form is locked for changes.
    locked: bool = false,

    /// The status of the evaluation form.
    status: EvaluationFormVersionStatus,

    pub const json_field_names = .{
        .created_by = "CreatedBy",
        .created_time = "CreatedTime",
        .evaluation_form_arn = "EvaluationFormArn",
        .evaluation_form_id = "EvaluationFormId",
        .evaluation_form_version = "EvaluationFormVersion",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .locked = "Locked",
        .status = "Status",
    };
};
