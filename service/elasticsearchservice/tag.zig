/// Specifies a key value pair for a resource tag.
pub const Tag = struct {
    /// Specifies the `TagKey`, the name of the tag. Tag keys must be unique for the
    /// Elasticsearch domain to which they are attached.
    key: []const u8,

    /// Specifies the `TagValue`, the value assigned to the corresponding tag key.
    /// Tag values can be null and do not have to be unique in a tag set. For
    /// example, you can have a key value
    /// pair in a tag set of `project : Trinity` and `cost-center : Trinity`
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
