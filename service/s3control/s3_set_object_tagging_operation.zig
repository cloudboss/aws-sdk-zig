const S3Tag = @import("s3_tag.zig").S3Tag;

/// Contains the configuration parameters for a
/// PUT
/// Object Tagging operation. S3 Batch Operations passes every object to the
/// underlying
/// `PutObjectTagging`
/// API
/// operation. For more information about the parameters for this operation,
/// see
/// [PutObjectTagging](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectPUTtagging.html).
pub const S3SetObjectTaggingOperation = struct {
    tag_set: ?[]const S3Tag,
};
