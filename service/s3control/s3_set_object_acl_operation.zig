const S3AccessControlPolicy = @import("s3_access_control_policy.zig").S3AccessControlPolicy;

/// Contains the configuration parameters for a
/// PUT
/// Object ACL operation. S3 Batch Operations passes every object to the
/// underlying
/// `PutObjectAcl`
/// API
/// operation. For more information about the parameters for this operation,
/// see
/// [PutObjectAcl](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectPUTacl.html).
pub const S3SetObjectAclOperation = struct {
    access_control_policy: ?S3AccessControlPolicy,
};
