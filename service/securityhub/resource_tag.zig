/// Represents tag information associated with Amazon Web Services resources.
pub const ResourceTag = struct {
    /// The identifier or name of the tag.
    key: []const u8,

    /// The data associated with the tag key.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
