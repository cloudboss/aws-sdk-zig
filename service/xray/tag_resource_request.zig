const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Number (ARN) of an X-Ray group or sampling rule.
    resource_arn: []const u8,

    /// A map that contains one or more tag keys and tag values to attach to an
    /// X-Ray group or
    /// sampling rule. For more information about ways to use tags, see [Tagging
    /// Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the *Amazon Web Services General Reference*.
    ///
    /// The following restrictions apply to tags:
    ///
    /// * Maximum number of user-applied tags per resource: 50
    ///
    /// * Maximum tag key length: 128 Unicode characters
    ///
    /// * Maximum tag value length: 256 Unicode characters
    ///
    /// * Valid values for key and value: a-z, A-Z, 0-9, space, and the following
    ///   characters: _ . :
    /// / = + - and @
    ///
    /// * Tag keys and values are case sensitive.
    ///
    /// * Don't use `aws:` as a prefix for keys; it's reserved for Amazon Web
    ///   Services use. You
    /// cannot edit or delete system tags.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tags = "Tags",
    };
};
