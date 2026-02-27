/// Specifies the name of the metadata attribute/field to apply filters. You
/// must match the name of the attribute/field in your data source/document
/// metadata.
pub const FilterAttribute = struct {
    /// The name of metadata attribute/field, which must match the name in your data
    /// source/document metadata.
    key: []const u8,

    /// The value of the metadata attribute/field.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
