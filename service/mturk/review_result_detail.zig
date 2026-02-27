/// This data structure is returned multiple times for each
/// result specified in the Review Policy.
pub const ReviewResultDetail = struct {
    /// A unique identifier of the Review action result.
    action_id: ?[]const u8,

    /// Key identifies the particular piece of reviewed information.
    key: ?[]const u8,

    /// Specifies the QuestionId the result is describing. Depending
    /// on whether the TargetType is a HIT or Assignment this results could
    /// specify multiple values. If TargetType is HIT and QuestionId is
    /// absent, then the result describes results of the HIT, including the
    /// HIT agreement score. If ObjectType is Assignment and QuestionId is
    /// absent, then the result describes the Worker's performance on the
    /// HIT.
    question_id: ?[]const u8,

    /// The HITID or AssignmentId about which this result was taken.
    /// Note that HIT-level Review Policies will often emit results about
    /// both the HIT itself and its Assignments, while Assignment-level
    /// review policies generally only emit results about the Assignment
    /// itself.
    subject_id: ?[]const u8,

    /// The type of the object from the SubjectId field.
    subject_type: ?[]const u8,

    /// The values of Key provided by the review policies you have
    /// selected.
    value: ?[]const u8,

    pub const json_field_names = .{
        .action_id = "ActionId",
        .key = "Key",
        .question_id = "QuestionId",
        .subject_id = "SubjectId",
        .subject_type = "SubjectType",
        .value = "Value",
    };
};
