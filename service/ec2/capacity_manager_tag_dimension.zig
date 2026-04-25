/// A key-value pair representing a tag associated with a capacity resource in
/// Capacity Manager.
pub const CapacityManagerTagDimension = struct {
    /// The tag key.
    key: ?[]const u8 = null,

    /// The tag value.
    value: ?[]const u8 = null,
};
