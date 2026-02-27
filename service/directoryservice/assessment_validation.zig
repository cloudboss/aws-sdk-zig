/// Contains information about a specific validation test performed during a
/// directory
/// assessment.
pub const AssessmentValidation = struct {
    /// The category of the validation test.
    category: ?[]const u8,

    /// The date and time when the validation test was completed or last updated.
    last_update_date_time: ?i64,

    /// The name of the specific validation test performed within the category.
    name: ?[]const u8,

    /// The date and time when the validation test was started.
    start_time: ?i64,

    /// The result status of the validation test. Valid values include `SUCCESS`,
    /// `FAILED`, `PENDING`, and `IN_PROGRESS`.
    status: ?[]const u8,

    /// A detailed status code providing additional information about the validation
    /// result.
    status_code: ?[]const u8,

    /// A human-readable description of the validation result, including any error
    /// details or
    /// recommendations.
    status_reason: ?[]const u8,

    pub const json_field_names = .{
        .category = "Category",
        .last_update_date_time = "LastUpdateDateTime",
        .name = "Name",
        .start_time = "StartTime",
        .status = "Status",
        .status_code = "StatusCode",
        .status_reason = "StatusReason",
    };
};
