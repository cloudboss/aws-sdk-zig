/// The resource tags that Firewall Manager uses to determine if a particular
/// resource
/// should be included or excluded from the Firewall Manager policy. Tags enable
/// you to
/// categorize your Amazon Web Services resources in different ways, for
/// example, by purpose, owner, or
/// environment. Each tag consists of a key and an optional value. If you add
/// more than one tag to a policy, you can
/// specify whether to combine them using the logical AND operator or the
/// logical OR operator. For more information, see
/// [Working with Tag
/// Editor](https://docs.aws.amazon.com/awsconsolehelpdocs/latest/gsg/tag-editor.html).
///
/// Every resource tag must have a string value, either a non-empty string or an
/// empty string. If you don't
/// provide a value for a resource tag, Firewall Manager saves the value as an
/// empty string: "". When Firewall Manager compares tags, it only
/// matches two tags if they have the same key and the same value. A tag with an
/// empty string value only
/// matches with tags that also have an empty string value.
pub const ResourceTag = struct {
    /// The resource tag key.
    key: []const u8,

    /// The resource tag value. To specify an empty string value, either don't
    /// provide this or specify it as "".
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
