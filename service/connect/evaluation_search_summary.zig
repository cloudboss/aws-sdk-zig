const aws = @import("aws");

const EvaluationType = @import("evaluation_type.zig").EvaluationType;
const EvaluationSearchMetadata = @import("evaluation_search_metadata.zig").EvaluationSearchMetadata;
const EvaluationStatus = @import("evaluation_status.zig").EvaluationStatus;

/// Summary of evaluation obtained from the search operation.
pub const EvaluationSearchSummary = struct {
    /// The date and time when the evaluation was created, in UTC time.
    created_time: i64,

    /// The Amazon Resource Name (ARN) for the contact evaluation resource.
    evaluation_arn: []const u8,

    /// The unique identifier for the evaluation form.
    evaluation_form_id: ?[]const u8,

    /// Title of the evaluation form.
    evaluation_form_title: ?[]const u8,

    /// A version of the evaluation form.
    evaluation_form_version: i32,

    /// A unique identifier for the contact evaluation.
    evaluation_id: []const u8,

    /// Type of the evaluation.
    evaluation_type: ?EvaluationType,

    /// The date and time when the evaluation was modified last time, in UTC time.
    last_modified_time: i64,

    /// Summary information about the evaluation search.
    metadata: EvaluationSearchMetadata,

    /// The status of the evaluation.
    status: EvaluationStatus,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .evaluation_arn = "EvaluationArn",
        .evaluation_form_id = "EvaluationFormId",
        .evaluation_form_title = "EvaluationFormTitle",
        .evaluation_form_version = "EvaluationFormVersion",
        .evaluation_id = "EvaluationId",
        .evaluation_type = "EvaluationType",
        .last_modified_time = "LastModifiedTime",
        .metadata = "Metadata",
        .status = "Status",
        .tags = "Tags",
    };
};
