/// Specifies a key-value pair for a resource tag.
pub const Tag = struct {
    /// A value that specifies the `TagKey`, the name of the tag. Tag keys must
    /// be unique for the resource to which they are attached.
    key: []const u8,

    /// A value that specifies the `TagValue`, the value assigned to the
    /// corresponding tag key. Tag values can be null and don't have to be unique in
    /// a tag set.
    /// For example, you can have a key-value pair in a tag set of `finances :
    /// April`
    /// and also of `payroll : April`.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
