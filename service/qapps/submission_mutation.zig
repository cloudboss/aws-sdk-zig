const SubmissionMutationKind = @import("submission_mutation_kind.zig").SubmissionMutationKind;

/// Represents an action performed on a submission.
pub const SubmissionMutation = struct {
    /// The operation that is performed on a submission.
    mutation_type: SubmissionMutationKind,

    /// The unique identifier of the submission.
    submission_id: []const u8,

    pub const json_field_names = .{
        .mutation_type = "mutationType",
        .submission_id = "submissionId",
    };
};
