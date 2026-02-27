/// The additional attributes of `RecommendedAction` data type.
pub const ContextAttribute = struct {
    /// The key of `ContextAttribute`.
    key: ?[]const u8,

    /// The value of `ContextAttribute`.
    value: ?[]const u8,
};
