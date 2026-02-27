/// A tag set contains tag key and tag value.
pub const TagSet = struct {
    /// The tag key in the TagSet.
    key: ?[]const u8,

    /// The tag value in the tagSet.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
