const KeyGroupConfig = @import("key_group_config.zig").KeyGroupConfig;

/// A key group.
///
/// A key group contains a list of public keys that you can use with [CloudFront
/// signed URLs and signed
/// cookies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PrivateContent.html).
pub const KeyGroup = struct {
    /// The identifier for the key group.
    id: []const u8,

    /// The key group configuration.
    key_group_config: KeyGroupConfig,

    /// The date and time when the key group was last modified.
    last_modified_time: i64,
};
