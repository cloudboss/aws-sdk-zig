/// An object that defines the tags associated with an application. A
/// *tag* is a label that you optionally define and associate with an
/// application. Tags can help you categorize and manage resources in different
/// ways, such as
/// by purpose, owner, environment, or other criteria.
///
/// Each tag consists of a required *tag key* and an associated
/// *tag value*, both of which you define. A tag key is a general label
/// that acts as a category for a more specific tag value. A tag value acts as a
/// descriptor
/// within a tag key. A tag key can contain as many as 128 characters. A tag
/// value can contain
/// as many as 256 characters. The characters can be Unicode letters, digits,
/// white space, or
/// one of the following symbols: _ . : / = + -. The following additional
/// restrictions apply to
/// tags:
///
/// * Tag keys and values are case sensitive.
///
/// * For each associated resource, each tag key must be unique and it can have
///   only one
/// value.
///
/// * The `aws:` prefix is reserved for use by Amazon Web Services; you can’t
///   use it in any
/// tag keys or values that you define. In addition, you can't edit or remove
/// tag keys or
/// values that use this prefix.
pub const Tag = struct {
    /// One part of a key-value pair that defines a tag. The maximum length of a tag
    /// key is 128
    /// characters. The minimum length is 1 character.
    key: []const u8,

    /// The optional part of a key-value pair that defines a tag. The maximum length
    /// of a tag
    /// value is 256 characters. The minimum length is 0 characters. If you don't
    /// want an
    /// application to have a specific tag value, don't specify a value for this
    /// parameter.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
