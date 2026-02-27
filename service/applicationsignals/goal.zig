const Interval = @import("interval.zig").Interval;

/// This structure contains the attributes that determine the goal of an SLO.
/// This includes the time period for evaluation and the attainment threshold.
pub const Goal = struct {
    /// The threshold that determines if the goal is being met.
    ///
    /// If this is a period-based SLO, the attainment goal is the percentage of good
    /// periods that meet the threshold requirements to the total periods within the
    /// interval. For example, an attainment goal of 99.9% means that within your
    /// interval, you are targeting 99.9% of the periods to be in healthy state.
    ///
    /// If this is a request-based SLO, the attainment goal is the percentage of
    /// requests that must be successful to meet the attainment goal.
    ///
    /// If you omit this parameter, 99 is used to represent 99% as the attainment
    /// goal.
    attainment_goal: ?f64,

    /// The time period used to evaluate the SLO. It can be either a calendar
    /// interval or rolling interval.
    ///
    /// If you omit this parameter, a rolling interval of 7 days is used.
    interval: ?Interval,

    /// The percentage of remaining budget over total budget that you want to get
    /// warnings for. If you omit this parameter, the default of 50.0 is used.
    warning_threshold: ?f64,

    pub const json_field_names = .{
        .attainment_goal = "AttainmentGoal",
        .interval = "Interval",
        .warning_threshold = "WarningThreshold",
    };
};
