/// A structure that allows an LF-admin to grant permissions on certain
/// conditions.
pub const LFTag = struct {
    /// The key name for the LF-tag.
    tag_key: []const u8,

    /// A list of LF-tag values.
    tag_values: []const []const u8,

    pub const json_field_names = .{
        .tag_key = "TagKey",
        .tag_values = "TagValues",
    };
};
