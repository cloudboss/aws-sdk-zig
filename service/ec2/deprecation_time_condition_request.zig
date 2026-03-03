/// The maximum period since deprecation for allowed images.
pub const DeprecationTimeConditionRequest = struct {
    /// The maximum number of days that have elapsed since the image was deprecated.
    /// Set to
    /// `0` to exclude all deprecated images.
    maximum_days_since_deprecated: ?i32 = null,
};
