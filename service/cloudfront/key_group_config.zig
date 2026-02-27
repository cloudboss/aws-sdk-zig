/// A key group configuration.
///
/// A key group contains a list of public keys that you can use with [CloudFront
/// signed URLs and signed
/// cookies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PrivateContent.html).
pub const KeyGroupConfig = struct {
    /// A comment to describe the key group. The comment cannot be longer than 128
    /// characters.
    comment: ?[]const u8,

    /// A list of the identifiers of the public keys in the key group.
    items: []const []const u8,

    /// A name to identify the key group.
    name: []const u8,
};
