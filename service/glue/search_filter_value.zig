/// A filter value. Exactly one of `stringValue` or `longValue` must be
/// specified.
pub const SearchFilterValue = union(enum) {
    /// A long integer filter value.
    long_value: ?i64,
    /// A string filter value.
    string_value: ?[]const u8,

    pub const json_field_names = .{
        .long_value = "LongValue",
        .string_value = "StringValue",
    };
};
