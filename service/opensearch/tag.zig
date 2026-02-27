/// A tag (key-value pair) for an Amazon OpenSearch Service resource.
pub const Tag = struct {
    /// The tag key. Tag keys must be unique for the domain to which they are
    /// attached.
    key: []const u8,

    /// The value assigned to the corresponding tag key. Tag values can be null and
    /// don't have
    /// to be unique in a tag set. For example, you can have a key value pair in a
    /// tag set of
    /// `project : Trinity` and `cost-center : Trinity`
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
