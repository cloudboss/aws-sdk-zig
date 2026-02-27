pub const ListTagsForResourceRequest = struct {
    /// The Amazon Web Services account ID of the resource owner.
    account_id: []const u8,

    /// The Amazon Resource Name (ARN) of the S3 resource that you want to list tags
    /// for. The tagged resource can be a directory bucket, S3 Storage Lens group or
    /// S3 Access Grants instance, registered location, or grant.
    resource_arn: []const u8,
};
