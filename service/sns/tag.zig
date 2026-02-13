/// The list of tags to be added to the specified topic.
pub const Tag = struct {
    /// The required key portion of the tag.
    key: []const u8,

    /// The optional value portion of the tag.
    value: []const u8,
};
