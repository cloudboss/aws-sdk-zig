/// The managed storage configuration for the cluster.
pub const ManagedStorageConfiguration = struct {
    /// Specify the Key
    /// Management Service key ID for Fargate ephemeral storage.
    ///
    /// When you specify a `fargateEphemeralStorageKmsKeyId`, Amazon Web Services
    /// Fargate uses the key to encrypt data at rest in ephemeral storage. For more
    /// information
    /// about Fargate ephemeral storage encryption, see [Customer managed keys for
    /// Amazon Web Services Fargate ephemeral
    /// storage for Amazon
    /// ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/fargate-storage-encryption.html) in the *Amazon Elastic Container Service
    /// Developer Guide*.
    ///
    /// The key must be a single Region key.
    fargate_ephemeral_storage_kms_key_id: ?[]const u8 = null,

    /// Specify a Key
    /// Management Service key ID to encrypt Amazon ECS managed storage.
    ///
    /// When you specify a `kmsKeyId`, Amazon ECS uses the key to encrypt data
    /// volumes managed by Amazon ECS that are attached to tasks in the cluster. The
    /// following
    /// data volumes are managed by Amazon ECS: Amazon EBS. For more information
    /// about
    /// encryption of Amazon EBS volumes attached to Amazon ECS tasks, see [Encrypt
    /// data stored in Amazon EBS volumes for Amazon
    /// ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ebs-kms-encryption.html) in the
    /// *Amazon Elastic Container Service Developer Guide*.
    ///
    /// The key must be a single Region key.
    kms_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .fargate_ephemeral_storage_kms_key_id = "fargateEphemeralStorageKmsKeyId",
        .kms_key_id = "kmsKeyId",
    };
};
