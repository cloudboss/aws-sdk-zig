const Status = @import("status.zig").Status;

/// Information about the contact evaluations where the key is the FormId, which
/// is a unique identifier for the
/// form.
pub const ContactEvaluation = struct {
    /// The date and time when the evaluation was deleted, in UTC time.
    delete_timestamp: ?i64,

    /// The date and time when the evaluation was submitted, in UTC time.
    end_timestamp: ?i64,

    /// The Amazon Resource Name for the evaluation form. It is always present.
    evaluation_arn: ?[]const u8,

    /// The path where evaluation was exported.
    export_location: ?[]const u8,

    /// The `FormId` of the contact evaluation.
    form_id: ?[]const u8,

    /// The date and time when the evaluation was started, in UTC time.
    start_timestamp: ?i64,

    /// The status of the evaluation.
    status: ?Status,

    pub const json_field_names = .{
        .delete_timestamp = "DeleteTimestamp",
        .end_timestamp = "EndTimestamp",
        .evaluation_arn = "EvaluationArn",
        .export_location = "ExportLocation",
        .form_id = "FormId",
        .start_timestamp = "StartTimestamp",
        .status = "Status",
    };
};
