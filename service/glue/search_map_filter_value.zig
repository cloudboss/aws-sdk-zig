/// A map filter value. Currently supports string comparison only.
pub const SearchMapFilterValue = union(enum) {
    /// A string filter value.
    string_value: ?[]const u8,

    pub const json_field_names = .{
        .string_value = "StringValue",
    };
};
