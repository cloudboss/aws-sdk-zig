const Tags = @import("tags.zig").Tags;

/// The request to add tags to a CloudFront resource.
pub const TagResourceRequest = struct {
    /// An ARN of a CloudFront resource.
    resource: []const u8,

    /// A complex type that contains zero or more `Tag` elements.
    tags: Tags,
};
