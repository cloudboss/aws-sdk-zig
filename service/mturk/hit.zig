const HITReviewStatus = @import("hit_review_status.zig").HITReviewStatus;
const HITStatus = @import("hit_status.zig").HITStatus;
const QualificationRequirement = @import("qualification_requirement.zig").QualificationRequirement;

/// The HIT data structure represents a single HIT, including
/// all the information necessary for a Worker to accept and complete the
/// HIT.
pub const HIT = struct {
    /// The length of time, in seconds, that a Worker has to
    /// complete the HIT after accepting it.
    assignment_duration_in_seconds: ?i64,

    /// The amount of time, in seconds, after the Worker submits an
    /// assignment for the HIT that the results are automatically approved by
    /// Amazon Mechanical Turk. This is the amount of time the Requester has
    /// to reject an assignment submitted by a Worker before the assignment
    /// is auto-approved and the Worker is paid.
    auto_approval_delay_in_seconds: ?i64,

    /// The date and time the HIT was created.
    creation_time: ?i64,

    /// A general description of the HIT.
    description: ?[]const u8,

    /// The date and time the HIT expires.
    expiration: ?i64,

    /// The ID of the HIT Group of this HIT.
    hit_group_id: ?[]const u8,

    /// A unique identifier for the HIT.
    hit_id: ?[]const u8,

    /// The ID of the HIT Layout of this HIT.
    hit_layout_id: ?[]const u8,

    /// Indicates the review status of the HIT. Valid Values are
    /// NotReviewed | MarkedForReview | ReviewedAppropriate |
    /// ReviewedInappropriate.
    hit_review_status: ?HITReviewStatus,

    /// The status of the HIT and its assignments. Valid Values are
    /// Assignable | Unassignable | Reviewable | Reviewing | Disposed.
    hit_status: ?HITStatus,

    /// The ID of the HIT type of this HIT
    hit_type_id: ?[]const u8,

    /// One or more words or phrases that describe the HIT,
    /// separated by commas. Search terms similar to the keywords of a HIT
    /// are more likely to have the HIT in the search results.
    keywords: ?[]const u8,

    /// The number of times the HIT can be accepted and completed
    /// before the HIT becomes unavailable.
    max_assignments: ?i32,

    /// The number of assignments for this HIT that are available
    /// for Workers to accept.
    number_of_assignments_available: ?i32,

    /// The number of assignments for this HIT that have been
    /// approved or rejected.
    number_of_assignments_completed: ?i32,

    /// The number of assignments for this HIT that are being
    /// previewed or have been accepted by Workers, but have not yet been
    /// submitted, returned, or abandoned.
    number_of_assignments_pending: ?i32,

    /// Conditions that a Worker's Qualifications must meet in order
    /// to accept the HIT. A HIT can have between zero and ten
    /// Qualification requirements. All requirements must be met in
    /// order for a Worker to accept the HIT. Additionally, other
    /// actions can be restricted using the `ActionsGuarded`
    /// field on each `QualificationRequirement` structure.
    qualification_requirements: ?[]const QualificationRequirement,

    /// The data the Worker completing the HIT uses produce the
    /// results. This is either either a QuestionForm, HTMLQuestion or an
    /// ExternalQuestion data structure.
    question: ?[]const u8,

    /// An arbitrary data field the Requester who created the HIT
    /// can use. This field is visible only to the creator of the HIT.
    requester_annotation: ?[]const u8,

    reward: ?[]const u8,

    /// The title of the HIT.
    title: ?[]const u8,

    pub const json_field_names = .{
        .assignment_duration_in_seconds = "AssignmentDurationInSeconds",
        .auto_approval_delay_in_seconds = "AutoApprovalDelayInSeconds",
        .creation_time = "CreationTime",
        .description = "Description",
        .expiration = "Expiration",
        .hit_group_id = "HITGroupId",
        .hit_id = "HITId",
        .hit_layout_id = "HITLayoutId",
        .hit_review_status = "HITReviewStatus",
        .hit_status = "HITStatus",
        .hit_type_id = "HITTypeId",
        .keywords = "Keywords",
        .max_assignments = "MaxAssignments",
        .number_of_assignments_available = "NumberOfAssignmentsAvailable",
        .number_of_assignments_completed = "NumberOfAssignmentsCompleted",
        .number_of_assignments_pending = "NumberOfAssignmentsPending",
        .qualification_requirements = "QualificationRequirements",
        .question = "Question",
        .requester_annotation = "RequesterAnnotation",
        .reward = "Reward",
        .title = "Title",
    };
};
