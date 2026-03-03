const ReviewStatus = @import("review_status.zig").ReviewStatus;
const Stage = @import("stage.zig").Stage;

/// Provides the lifecycle view of an opportunity resource shared through a
/// snapshot.
pub const LifeCycleForView = struct {
    /// Describes the next steps for the opportunity shared through a snapshot.
    next_steps: ?[]const u8 = null,

    /// Defines the approval status of the opportunity shared through a snapshot.
    review_status: ?ReviewStatus = null,

    /// Defines the current stage of the opportunity shared through a snapshot.
    stage: ?Stage = null,

    /// The projected launch date of the opportunity shared through a snapshot.
    target_close_date: ?[]const u8 = null,

    pub const json_field_names = .{
        .next_steps = "NextSteps",
        .review_status = "ReviewStatus",
        .stage = "Stage",
        .target_close_date = "TargetCloseDate",
    };
};
