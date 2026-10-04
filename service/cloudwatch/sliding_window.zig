/// An evaluation window that advances each time the alarm is evaluated, forming
/// a rolling
/// time window. This is the default evaluation window. A sliding window has no
/// additional
/// configuration options.
///
/// Choose a sliding window when you need the fastest detection and the calendar
/// boundaries of the data don't matter, such as for continuous performance,
/// latency, or
/// resource-exhaustion monitoring.
pub const SlidingWindow = struct {
};
