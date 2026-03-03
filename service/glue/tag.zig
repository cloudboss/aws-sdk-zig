/// The `Tag` object represents a label that you can assign to an Amazon Web
/// Services resource. Each tag consists of a key and an optional value, both of
/// which you define.
///
/// For more information about tags, and controlling access to resources in
/// Glue, see
/// [Amazon Web Services Tags in
/// Glue](https://docs.aws.amazon.com/glue/latest/dg/monitor-tags.html) and
/// [Specifying Glue Resource
/// ARNs](https://docs.aws.amazon.com/glue/latest/dg/glue-specifying-resource-arns.html) in the developer guide.
pub const Tag = struct {
    /// The tag key. The key is required when you create a tag on an object. The key
    /// is case-sensitive, and must not contain the prefix aws.
    key: ?[]const u8 = null,

    /// The tag value. The value is optional when you create a tag on an object. The
    /// value is case-sensitive, and must not contain the prefix aws.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
