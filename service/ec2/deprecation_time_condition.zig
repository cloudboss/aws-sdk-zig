/// The maximum period since deprecation for allowed images.
pub const DeprecationTimeCondition = struct {
    /// The maximum number of days that have elapsed since the image was deprecated.
    /// When set to
    /// `0`, no deprecated images are allowed.
    maximum_days_since_deprecated: ?i32,
};
