/// A single parameter to use with the `RecommendedAction` API operation to
/// apply the action.
pub const RecommendedActionParameter = struct {
    /// The key of the parameter to use with the `RecommendedAction` API operation.
    key: ?[]const u8 = null,

    /// The value of the parameter to use with the `RecommendedAction` API
    /// operation.
    value: ?[]const u8 = null,
};
