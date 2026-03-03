/// A leaf node condition which can be used to specify a tag condition.
pub const TagCondition = struct {
    /// The tag key in the tag condition.
    key: []const u8,

    /// The tag value in the tag condition.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
