const SlidingWindow = @import("sliding_window.zig").SlidingWindow;
const WallClockWindow = @import("wall_clock_window.zig").WallClockWindow;

/// The evaluation window that an alarm uses to select the range of metric data
/// that it
/// evaluates each time it runs. This is a union type. Set exactly one of its
/// members,
/// `SlidingWindow` or `WallClockWindow`. If you don't set
/// `EvaluationWindow`, the alarm uses a `SlidingWindow` by
/// default.
///
/// For more information, see [Alarm
/// evaluation
/// windows](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/alarm-evaluation-window.html) in the *CloudWatch User
/// Guide*.
pub const EvaluationWindow = union(enum) {
    /// A sliding window, which advances each time the alarm is evaluated, forming a
    /// rolling
    /// time window. This is the default evaluation window.
    sliding_window: ?SlidingWindow,
    /// A wall clock window, which aligns the evaluated range to fixed clock
    /// boundaries that
    /// match the alarm's period, such as the top of the hour, midnight, or the
    /// start of the
    /// calendar week.
    wall_clock_window: ?WallClockWindow,

    pub const json_field_names = .{
        .sliding_window = "SlidingWindow",
        .wall_clock_window = "WallClockWindow",
    };
};
