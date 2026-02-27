/// An object that defines the tags that are associated with a resource.
/// A *tag* is a label that you optionally define and associate with
/// a resource. Tags can help you categorize and manage resources in different
/// ways, such as
/// by purpose, owner, environment, or other criteria. A resource can have as
/// many as 50
/// tags.
///
/// Each tag consists of a required *tag key* and an
/// associated *tag value*, both of which you define. A tag key is a
/// general label that acts as a category for a more specific tag value. A tag
/// value acts as
/// a descriptor within a tag key. A tag key can contain as many as 128
/// characters. A tag
/// value can contain as many as 256 characters. The characters can be Unicode
/// letters,
/// digits, white space, or one of the following symbols: _ . : / = + -. The
/// following
/// additional restrictions apply to tags:
///
/// * Tag keys and values are case sensitive.
///
/// * For each associated resource, each tag key must be unique and it can have
///   only
/// one value.
///
/// * The `aws:` prefix is reserved for use by Amazon Web Services; you can’t
///   use it in
/// any tag keys or values that you define. In addition, you can't edit or
/// remove
/// tag keys or values that use this prefix. Tags that use this prefix don’t
/// count
/// against the limit of 50 tags per resource.
///
/// * You can associate tags with public or shared resources, but the tags are
/// available only for your Amazon Web Services account, not any other accounts
/// that share the
/// resource. In addition, the tags are available only for resources that are
/// located in the specified Amazon Web Services Region for your Amazon Web
/// Services account.
pub const Tag = struct {
    /// One part of a key-value pair that defines a tag. The maximum length of a tag
    /// key is
    /// 128 characters. The minimum length is 1 character.
    key: []const u8,

    /// The optional part of a key-value pair that defines a tag. The maximum length
    /// of a tag
    /// value is 256 characters. The minimum length is 0 characters. If you don't
    /// want a
    /// resource to have a specific tag value, don't specify a value for
    /// this parameter. If you
    /// don't specify a value, Amazon SES sets the value to an empty string.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
