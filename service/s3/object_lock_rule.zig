const DefaultRetention = @import("default_retention.zig").DefaultRetention;

/// The container element for an Object Lock rule.
pub const ObjectLockRule = struct {
    /// The default Object Lock retention mode and period that you want to apply to
    /// new objects placed in
    /// the specified bucket. Bucket settings require both a mode and a period. The
    /// period can be either
    /// `Days` or `Years` but you must select one. You cannot specify `Days`
    /// and `Years` at the same time.
    default_retention: ?DefaultRetention,
};
