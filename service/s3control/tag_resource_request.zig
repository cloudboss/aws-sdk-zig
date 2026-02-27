const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Web Services account ID that created the S3 resource that you're
    /// trying to add tags to or the requester's account ID.
    account_id: []const u8,

    /// The Amazon Resource Name (ARN) of the S3 resource that you're applying tags
    /// to. The tagged resource can be a directory bucket, S3 Storage Lens group or
    /// S3 Access Grants instance, registered location, or grant.
    resource_arn: []const u8,

    /// The Amazon Web Services resource tags that you want to add to the specified
    /// S3 resource.
    tags: []const Tag,
};
