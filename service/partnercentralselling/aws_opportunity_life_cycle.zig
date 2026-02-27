const AwsClosedLostReason = @import("aws_closed_lost_reason.zig").AwsClosedLostReason;
const ProfileNextStepsHistory = @import("profile_next_steps_history.zig").ProfileNextStepsHistory;
const AwsOpportunityStage = @import("aws_opportunity_stage.zig").AwsOpportunityStage;

/// Tracks the lifecycle of the AWS opportunity, including stages such as
/// qualification, validation, and closure. This field helps partners understand
/// the current status and progression of the opportunity.
pub const AwsOpportunityLifeCycle = struct {
    /// Indicates the reason why an opportunity was marked as `Closed Lost`. This
    /// helps in understanding the context behind the lost opportunity and aids in
    /// refining future strategies.
    closed_lost_reason: ?AwsClosedLostReason,

    /// Specifies the immediate next steps required to progress the opportunity.
    /// These steps are based on AWS guidance and the current stage of the
    /// opportunity.
    next_steps: ?[]const u8,

    /// Provides a historical log of previous next steps that were taken to move the
    /// opportunity forward. This helps in tracking the decision-making process and
    /// identifying any delays or obstacles encountered.
    next_steps_history: ?[]const ProfileNextStepsHistory,

    /// Represents the current stage of the opportunity in its lifecycle, such as
    /// `Qualification`, `Validation`, or `Closed Won`. This helps in understanding
    /// the opportunity's progress.
    stage: ?AwsOpportunityStage,

    /// Indicates the expected date by which the opportunity is projected to close.
    /// This field helps in planning resources and timelines for both the partner
    /// and AWS.
    target_close_date: ?[]const u8,

    pub const json_field_names = .{
        .closed_lost_reason = "ClosedLostReason",
        .next_steps = "NextSteps",
        .next_steps_history = "NextStepsHistory",
        .stage = "Stage",
        .target_close_date = "TargetCloseDate",
    };
};
