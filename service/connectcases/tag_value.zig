/// Object for case tag filter values.
pub const TagValue = struct {
    /// The tag key in the tag filter value.
    key: ?[]const u8 = null,

    /// The tag value in the tag filter value.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
