const DefaultRetention = @import("default_retention.zig").DefaultRetention;

/// The container element for an Object Lock rule.
pub const ObjectLockRule = struct {
    /// The default Object Lock retention settings for new objects in this bucket.
    /// You can
    /// specify:
    ///
    /// * A default retention period, by using `Days` or `Years`.
    ///
    /// * A default event hold duration, by using `DefaultEventHold`. This setting
    ///   also
    /// uses days or years.
    ///
    /// You can set one or both. You cannot use days and years in the same setting.
    default_retention: ?DefaultRetention = null,
};
