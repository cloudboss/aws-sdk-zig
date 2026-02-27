const ReviewActionStatus = @import("review_action_status.zig").ReviewActionStatus;

/// Both the AssignmentReviewReport and the HITReviewReport
/// elements contains the ReviewActionDetail data structure. This
/// structure is returned multiple times for each action specified in the
/// Review Policy.
pub const ReviewActionDetail = struct {
    /// The unique identifier for the action.
    action_id: ?[]const u8,

    /// The nature of the action itself. The Review Policy is
    /// responsible for examining the HIT and Assignments, emitting results,
    /// and deciding which other actions will be necessary.
    action_name: ?[]const u8,

    /// The date when the action was completed.
    complete_time: ?i64,

    /// Present only when the Results have a FAILED Status.
    error_code: ?[]const u8,

    /// A description of the outcome of the review.
    result: ?[]const u8,

    /// The current disposition of the action: INTENDED, SUCCEEDED,
    /// FAILED, or CANCELLED.
    status: ?ReviewActionStatus,

    /// The specific HITId or AssignmentID targeted by the action.
    target_id: ?[]const u8,

    /// The type of object in TargetId.
    target_type: ?[]const u8,

    pub const json_field_names = .{
        .action_id = "ActionId",
        .action_name = "ActionName",
        .complete_time = "CompleteTime",
        .error_code = "ErrorCode",
        .result = "Result",
        .status = "Status",
        .target_id = "TargetId",
        .target_type = "TargetType",
    };
};
