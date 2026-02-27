const DynamodbStreamConfiguration = @import("dynamodb_stream_configuration.zig").DynamodbStreamConfiguration;
const DynamodbTableConfiguration = @import("dynamodb_table_configuration.zig").DynamodbTableConfiguration;
const EbsSnapshotConfiguration = @import("ebs_snapshot_configuration.zig").EbsSnapshotConfiguration;
const EcrRepositoryConfiguration = @import("ecr_repository_configuration.zig").EcrRepositoryConfiguration;
const EfsFileSystemConfiguration = @import("efs_file_system_configuration.zig").EfsFileSystemConfiguration;
const IamRoleConfiguration = @import("iam_role_configuration.zig").IamRoleConfiguration;
const KmsKeyConfiguration = @import("kms_key_configuration.zig").KmsKeyConfiguration;
const RdsDbClusterSnapshotConfiguration = @import("rds_db_cluster_snapshot_configuration.zig").RdsDbClusterSnapshotConfiguration;
const RdsDbSnapshotConfiguration = @import("rds_db_snapshot_configuration.zig").RdsDbSnapshotConfiguration;
const S3BucketConfiguration = @import("s3_bucket_configuration.zig").S3BucketConfiguration;
const S3ExpressDirectoryBucketConfiguration = @import("s3_express_directory_bucket_configuration.zig").S3ExpressDirectoryBucketConfiguration;
const SecretsManagerSecretConfiguration = @import("secrets_manager_secret_configuration.zig").SecretsManagerSecretConfiguration;
const SnsTopicConfiguration = @import("sns_topic_configuration.zig").SnsTopicConfiguration;
const SqsQueueConfiguration = @import("sqs_queue_configuration.zig").SqsQueueConfiguration;

/// Access control configuration structures for your resource. You specify the
/// configuration as a type-value pair. You can specify only one type of access
/// control configuration.
pub const Configuration = union(enum) {
    /// The access control configuration is for a DynamoDB stream.
    dynamodb_stream: ?DynamodbStreamConfiguration,
    /// The access control configuration is for a DynamoDB table or index.
    dynamodb_table: ?DynamodbTableConfiguration,
    /// The access control configuration is for an Amazon EBS volume snapshot.
    ebs_snapshot: ?EbsSnapshotConfiguration,
    /// The access control configuration is for an Amazon ECR repository.
    ecr_repository: ?EcrRepositoryConfiguration,
    /// The access control configuration is for an Amazon EFS file system.
    efs_file_system: ?EfsFileSystemConfiguration,
    /// The access control configuration is for an IAM role.
    iam_role: ?IamRoleConfiguration,
    /// The access control configuration is for a KMS key.
    kms_key: ?KmsKeyConfiguration,
    /// The access control configuration is for an Amazon RDS DB cluster snapshot.
    rds_db_cluster_snapshot: ?RdsDbClusterSnapshotConfiguration,
    /// The access control configuration is for an Amazon RDS DB snapshot.
    rds_db_snapshot: ?RdsDbSnapshotConfiguration,
    /// The access control configuration is for an Amazon S3 bucket.
    s_3_bucket: ?S3BucketConfiguration,
    /// The access control configuration is for an Amazon S3 directory bucket.
    s_3_express_directory_bucket: ?S3ExpressDirectoryBucketConfiguration,
    /// The access control configuration is for a Secrets Manager secret.
    secrets_manager_secret: ?SecretsManagerSecretConfiguration,
    /// The access control configuration is for an Amazon SNS topic
    sns_topic: ?SnsTopicConfiguration,
    /// The access control configuration is for an Amazon SQS queue.
    sqs_queue: ?SqsQueueConfiguration,

    pub const json_field_names = .{
        .dynamodb_stream = "dynamodbStream",
        .dynamodb_table = "dynamodbTable",
        .ebs_snapshot = "ebsSnapshot",
        .ecr_repository = "ecrRepository",
        .efs_file_system = "efsFileSystem",
        .iam_role = "iamRole",
        .kms_key = "kmsKey",
        .rds_db_cluster_snapshot = "rdsDbClusterSnapshot",
        .rds_db_snapshot = "rdsDbSnapshot",
        .s_3_bucket = "s3Bucket",
        .s_3_express_directory_bucket = "s3ExpressDirectoryBucket",
        .secrets_manager_secret = "secretsManagerSecret",
        .sns_topic = "snsTopic",
        .sqs_queue = "sqsQueue",
    };
};
