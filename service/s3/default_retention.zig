const ObjectLockRetentionMode = @import("object_lock_retention_mode.zig").ObjectLockRetentionMode;

/// The container element for optionally specifying the default Object Lock
/// retention settings for new
/// objects placed in the specified bucket.
///
/// * The `DefaultRetention` settings require both a mode and a period.
///
/// * The `DefaultRetention` period can be either `Days` or `Years`
/// but you must select one. You cannot specify `Days` and `Years` at the same
/// time.
pub const DefaultRetention = struct {
    /// The number of days that you want to specify for the default retention
    /// period. Must be used with
    /// `Mode`.
    days: ?i32,

    /// The default Object Lock retention mode you want to apply to new objects
    /// placed in the specified
    /// bucket. Must be used with either `Days` or `Years`.
    mode: ?ObjectLockRetentionMode,

    /// The number of years that you want to specify for the default retention
    /// period. Must be used with
    /// `Mode`.
    years: ?i32,
};
