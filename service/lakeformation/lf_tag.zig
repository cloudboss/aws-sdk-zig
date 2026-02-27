/// A structure that allows an admin to grant user permissions on certain
/// conditions. For example, granting a role access to all columns that do not
/// have the LF-tag 'PII' in tables that have the LF-tag 'Prod'.
pub const LFTag = struct {
    /// The key-name for the LF-tag.
    tag_key: []const u8,

    /// A list of possible values an attribute can take.
    ///
    /// The maximum number of values that can be defined for a LF-Tag is 1000. A
    /// single API call
    /// supports 50 values. You can use multiple API calls to add more values.
    tag_values: []const []const u8,

    pub const json_field_names = .{
        .tag_key = "TagKey",
        .tag_values = "TagValues",
    };
};
