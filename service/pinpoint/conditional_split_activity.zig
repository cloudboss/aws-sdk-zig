const Condition = @import("condition.zig").Condition;
const WaitTime = @import("wait_time.zig").WaitTime;

/// Specifies the settings for a yes/no split activity in a journey. This type
/// of activity sends participants down one of two paths in a journey, based on
/// conditions that you specify.
///
/// To create yes/no split activities that send participants down different
/// paths based on push notification events (such as Open or Received events),
/// your mobile app has to specify the User ID and Endpoint ID values. For more
/// information, see [Integrating Amazon Pinpoint with your
/// application](https://docs.aws.amazon.com/pinpoint/latest/developerguide/integrate.html) in the *Amazon Pinpoint Developer Guide*.
pub const ConditionalSplitActivity = struct {
    /// The conditions that define the paths for the activity, and the relationship
    /// between the conditions.
    condition: ?Condition = null,

    /// The amount of time to wait before determining whether the conditions are
    /// met, or the date and time when Amazon Pinpoint determines whether the
    /// conditions are met.
    evaluation_wait_time: ?WaitTime = null,

    /// The unique identifier for the activity to perform if the conditions aren't
    /// met.
    false_activity: ?[]const u8 = null,

    /// The unique identifier for the activity to perform if the conditions are met.
    true_activity: ?[]const u8 = null,

    pub const json_field_names = .{
        .condition = "Condition",
        .evaluation_wait_time = "EvaluationWaitTime",
        .false_activity = "FalseActivity",
        .true_activity = "TrueActivity",
    };
};
