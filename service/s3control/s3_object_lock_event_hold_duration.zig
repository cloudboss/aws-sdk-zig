/// Contains the duration configuration for an event hold, specified in either
/// days or
/// years.
pub const S3ObjectLockEventHoldDuration = struct {
    /// The number of days for the event hold duration. The minimum value is 1 and
    /// the maximum
    /// value is 36,500.
    days: ?i32 = null,

    /// The number of years for the event hold duration. The minimum value is 1 and
    /// the maximum
    /// value is 100.
    years: ?i32 = null,
};
