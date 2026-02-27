const TagKeys = @import("tag_keys.zig").TagKeys;

/// The request to remove tags from a CloudFront resource.
pub const UntagResourceRequest = struct {
    /// An ARN of a CloudFront resource.
    resource: []const u8,

    /// A complex type that contains zero or more `Tag` key elements.
    tag_keys: TagKeys,
};
