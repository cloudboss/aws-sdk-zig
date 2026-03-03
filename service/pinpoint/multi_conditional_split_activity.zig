const MultiConditionalBranch = @import("multi_conditional_branch.zig").MultiConditionalBranch;
const WaitTime = @import("wait_time.zig").WaitTime;

/// Specifies the settings for a multivariate split activity in a journey. This
/// type of activity sends participants down one of as many as five paths
/// (including a default *Else* path) in a journey, based on conditions that you
/// specify.
///
/// To create multivariate split activities that send participants down
/// different paths based on push notification events (such as Open or Received
/// events), your mobile app has to specify the User ID and Endpoint ID values.
/// For more information, see [Integrating Amazon Pinpoint with your
/// application](https://docs.aws.amazon.com/pinpoint/latest/developerguide/integrate.html) in the *Amazon Pinpoint Developer Guide*.
pub const MultiConditionalSplitActivity = struct {
    /// The paths for the activity, including the conditions for entering each path
    /// and the activity to perform for each path.
    branches: ?[]const MultiConditionalBranch = null,

    /// The unique identifier for the activity to perform for participants who don't
    /// meet any of the conditions specified for other paths in the activity.
    default_activity: ?[]const u8 = null,

    /// The amount of time to wait or the date and time when Amazon Pinpoint
    /// determines whether the conditions are met.
    evaluation_wait_time: ?WaitTime = null,

    pub const json_field_names = .{
        .branches = "Branches",
        .default_activity = "DefaultActivity",
        .evaluation_wait_time = "EvaluationWaitTime",
    };
};
