const Period = @import("period.zig").Period;

/// Contains the rate configuration for a rate limit metric, specifying the
/// allowed rate and time period.
pub const RateConfig = struct {
    /// The time period for the rate limit. Valid values:
    ///
    /// * `second`—Measures the rate limit over a one-second window.
    /// * `minute`—Measures the rate limit over a one-minute window.
    period: Period,

    /// The rate value for the limit. For request limits, this is the number of
    /// requests allowed per period. For token limits, this is the number of tokens
    /// allowed per period. For connection limits, this is the number of concurrent
    /// connections allowed.
    rate: f64,

    pub const json_field_names = .{
        .period = "period",
        .rate = "rate",
    };
};
