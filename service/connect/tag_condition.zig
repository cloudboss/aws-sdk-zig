/// A leaf node condition which can be used to specify a tag condition, for
/// example, `HAVE BPO = 123`.
pub const TagCondition = struct {
    /// The tag key in the tag condition.
    tag_key: ?[]const u8,

    /// The tag value in the tag condition.
    tag_value: ?[]const u8,

    pub const json_field_names = .{
        .tag_key = "TagKey",
        .tag_value = "TagValue",
    };
};
