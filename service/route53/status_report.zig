/// A complex type that contains the status that one Amazon Route 53 health
/// checker
/// reports and the time of the health check.
pub const StatusReport = struct {
    /// The date and time that the health checker performed the health check in [ISO
    /// 8601 format](https://en.wikipedia.org/wiki/ISO_8601) and Coordinated
    /// Universal Time (UTC). For example, the value `2017-03-27T17:48:16.751Z`
    /// represents March 27, 2017 at 17:48:16.751 UTC.
    checked_time: ?i64 = null,

    /// A description of the status of the health check endpoint as reported by one
    /// of the
    /// Amazon Route 53 health checkers.
    status: ?[]const u8 = null,
};
