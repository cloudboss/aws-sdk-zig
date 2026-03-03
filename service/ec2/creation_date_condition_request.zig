/// The maximum age for allowed images.
pub const CreationDateConditionRequest = struct {
    /// The maximum number of days that have elapsed since the image was created.
    /// For example, a
    /// value of `300` allows images that were created within the last 300 days.
    maximum_days_since_created: ?i32 = null,
};
