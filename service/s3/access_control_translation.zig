const OwnerOverride = @import("owner_override.zig").OwnerOverride;

/// A container for information about access control for replicas.
pub const AccessControlTranslation = struct {
    /// Specifies the replica ownership. For default and valid values, see [PUT
    /// bucket
    /// replication](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTreplication.html) in the
    /// *Amazon S3 API Reference*.
    owner: OwnerOverride,
};
