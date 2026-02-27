/// The request to list tags for a CloudFront resource.
pub const ListTagsForResourceRequest = struct {
    /// An ARN of a CloudFront resource.
    resource: []const u8,
};
