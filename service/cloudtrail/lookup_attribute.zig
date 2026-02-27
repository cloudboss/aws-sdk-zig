const LookupAttributeKey = @import("lookup_attribute_key.zig").LookupAttributeKey;

/// Specifies an attribute and value that filter the events returned.
pub const LookupAttribute = struct {
    /// Specifies an attribute on which to filter the events returned.
    attribute_key: LookupAttributeKey,

    /// Specifies a value for the specified `AttributeKey`.
    ///
    /// The maximum length for the `AttributeValue` is 2000 characters. The
    /// following characters ('`_`', '` `', '`,`',
    /// '`\\n`') count as two characters towards the 2000 character limit.
    attribute_value: []const u8,

    pub const json_field_names = .{
        .attribute_key = "AttributeKey",
        .attribute_value = "AttributeValue",
    };
};
