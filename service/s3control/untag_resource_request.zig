pub const UntagResourceRequest = struct {
    /// The Amazon Web Services account ID that owns the resource that you're trying
    /// to remove the tags from.
    account_id: []const u8,

    /// The Amazon Resource Name (ARN) of the S3 resource that you're removing tags
    /// from. The tagged resource can be a directory bucket, S3 Storage Lens group
    /// or S3 Access Grants instance, registered location, or grant.
    resource_arn: []const u8,

    /// The array of tag key-value pairs that you're trying to remove from of the S3
    /// resource.
    tag_keys: []const []const u8,
};
