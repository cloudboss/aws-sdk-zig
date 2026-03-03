const aws = @import("aws");

const EvaluationAnswerOutput = @import("evaluation_answer_output.zig").EvaluationAnswerOutput;
const EvaluationType = @import("evaluation_type.zig").EvaluationType;
const EvaluationMetadata = @import("evaluation_metadata.zig").EvaluationMetadata;
const EvaluationNote = @import("evaluation_note.zig").EvaluationNote;
const EvaluationScore = @import("evaluation_score.zig").EvaluationScore;
const EvaluationStatus = @import("evaluation_status.zig").EvaluationStatus;

/// Information about a contact evaluation.
pub const Evaluation = struct {
    /// A map of question identifiers to answer value.
    answers: []const aws.map.MapEntry(EvaluationAnswerOutput),

    /// The timestamp for when the evaluation was created.
    created_time: i64,

    /// The Amazon Resource Name (ARN) for the contact evaluation resource.
    evaluation_arn: []const u8,

    /// A unique identifier for the contact evaluation.
    evaluation_id: []const u8,

    /// Type of the evaluation.
    evaluation_type: ?EvaluationType = null,

    /// The timestamp for when the evaluation was last updated.
    last_modified_time: i64,

    /// Metadata about the contact evaluation.
    metadata: EvaluationMetadata,

    /// A map of question identifiers to note value.
    notes: []const aws.map.MapEntry(EvaluationNote),

    /// A map of item (section or question) identifiers to score value.
    scores: ?[]const aws.map.MapEntry(EvaluationScore) = null,

    /// The status of the contact evaluation.
    status: EvaluationStatus,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .answers = "Answers",
        .created_time = "CreatedTime",
        .evaluation_arn = "EvaluationArn",
        .evaluation_id = "EvaluationId",
        .evaluation_type = "EvaluationType",
        .last_modified_time = "LastModifiedTime",
        .metadata = "Metadata",
        .notes = "Notes",
        .scores = "Scores",
        .status = "Status",
        .tags = "Tags",
    };
};
