const AssignmentStatus = @import("assignment_status.zig").AssignmentStatus;

/// The Assignment data structure represents a single assignment
/// of a HIT to a Worker. The assignment tracks the Worker's efforts to
/// complete the HIT, and contains the results for later retrieval.
pub const Assignment = struct {
    /// The date and time the Worker accepted the assignment.
    accept_time: ?i64,

    /// The Worker's answers submitted for the HIT contained in a
    /// QuestionFormAnswers document, if the Worker provides an answer. If
    /// the Worker does not provide any answers, Answer may contain a
    /// QuestionFormAnswers document, or Answer may be empty.
    answer: ?[]const u8,

    /// If the Worker has submitted results and the Requester has
    /// approved the results, ApprovalTime is the date and time the Requester
    /// approved the results. This value is omitted from the assignment if
    /// the Requester has not yet approved the results.
    approval_time: ?i64,

    /// A unique identifier for the assignment.
    assignment_id: ?[]const u8,

    /// The status of the assignment.
    assignment_status: ?AssignmentStatus,

    /// If results have been submitted, AutoApprovalTime is the date
    /// and time the results of the assignment results are considered
    /// Approved automatically if they have not already been explicitly
    /// approved or rejected by the Requester. This value is derived from the
    /// auto-approval delay specified by the Requester in the HIT. This value
    /// is omitted from the assignment if the Worker has not yet submitted
    /// results.
    auto_approval_time: ?i64,

    /// The date and time of the deadline for the assignment. This
    /// value is derived from the deadline specification for the HIT and the
    /// date and time the Worker accepted the HIT.
    deadline: ?i64,

    /// The ID of the HIT.
    hit_id: ?[]const u8,

    /// If the Worker has submitted results and the Requester has
    /// rejected the results, RejectionTime is the date and time the
    /// Requester rejected the results.
    rejection_time: ?i64,

    /// The feedback string included with the call to the
    /// ApproveAssignment operation or the RejectAssignment operation, if the
    /// Requester approved or rejected the assignment and specified feedback.
    requester_feedback: ?[]const u8,

    /// If the Worker has submitted results, SubmitTime is the date
    /// and time the assignment was submitted. This value is omitted from the
    /// assignment if the Worker has not yet submitted results.
    submit_time: ?i64,

    /// The ID of the Worker who accepted the HIT.
    worker_id: ?[]const u8,

    pub const json_field_names = .{
        .accept_time = "AcceptTime",
        .answer = "Answer",
        .approval_time = "ApprovalTime",
        .assignment_id = "AssignmentId",
        .assignment_status = "AssignmentStatus",
        .auto_approval_time = "AutoApprovalTime",
        .deadline = "Deadline",
        .hit_id = "HITId",
        .rejection_time = "RejectionTime",
        .requester_feedback = "RequesterFeedback",
        .submit_time = "SubmitTime",
        .worker_id = "WorkerId",
    };
};
