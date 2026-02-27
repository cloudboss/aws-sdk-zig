/// Metadata that is associated with Amazon Web Services resources. In
/// particular, a name-value pair that
/// can be associated with an Cloud9 development environment. There are two
/// types of tags:
/// *user tags* and *system tags*. A user tag is created
/// by the user. A system tag is automatically created by Amazon Web Services
/// services. A system tag is prefixed
/// with `"aws:"` and cannot be modified by the user.
pub const Tag = struct {
    /// The **name** part of a tag.
    key: []const u8,

    /// The **value** part of a tag.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
