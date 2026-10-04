/// The configuration settings that define the warm-up behavior for an alarm.
/// Use these
/// settings to delay alarm evaluation after you create or update the alarm,
/// which reduces
/// alarm noise while a new resource or service starts publishing data.
///
/// During the warm-up period, the alarm stays in `INSUFFICIENT_DATA` and
/// does not perform alarm actions.
pub const WarmUpConfiguration = struct {
    /// Specifies whether the alarm waits for the full warm-up period before it
    /// starts
    /// to evaluate. The default is `false`. If `true`, the alarm waits
    /// the entire `WarmUpPeriodDurationInMinutes` before it starts to evaluate,
    /// even
    /// if metric data arrives earlier. If `false`, the alarm ends the warm-up
    /// period
    /// early. Evaluation begins as soon as the alarm has enough metric data to fill
    /// its
    /// evaluation window.
    only_start_evaluating_after_warm_up_period_ends: ?bool = null,

    /// The length of the warm-up period, in minutes. After you create or update the
    /// alarm,
    /// the alarm stays in `INSUFFICIENT_DATA` for this duration. During this time,
    /// the alarm does not perform alarm actions.
    ///
    /// You can change this value at any time, including after the warm-up period
    /// ends. If
    /// you change it after the warm-up period ends, the new value does not restart
    /// the
    /// warm-up period.
    warm_up_period_duration_in_minutes: i32,

    pub const json_field_names = .{
        .only_start_evaluating_after_warm_up_period_ends = "OnlyStartEvaluatingAfterWarmUpPeriodEnds",
        .warm_up_period_duration_in_minutes = "WarmUpPeriodDurationInMinutes",
    };
};
