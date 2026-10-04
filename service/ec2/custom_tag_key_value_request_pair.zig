/// Describes a tag key-value pair for an application status check association
/// request.
pub const CustomTagKeyValueRequestPair = struct {
    /// The key of the tag.
    key: ?[]const u8 = null,

    /// The value of the tag.
    value: ?[]const u8 = null,
};
