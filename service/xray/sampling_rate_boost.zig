/// Enable temporary sampling rate increases when you detect anomalies to
/// improve visibility.
pub const SamplingRateBoost = struct {
    /// Sets the time window (in minutes) in which only one sampling rate boost can
    /// be triggered.
    /// After a boost occurs, no further boosts are allowed until the next window.
    cooldown_window_minutes: i32 = 0,

    /// Defines max temporary sampling rate to apply when a boost is triggered.
    /// Calculated boost rate by X-Ray will be less than or equal to this max rate.
    max_rate: f64 = 0,

    pub const json_field_names = .{
        .cooldown_window_minutes = "CooldownWindowMinutes",
        .max_rate = "MaxRate",
    };
};
