/// The lifecycle configuration for a SageMaker HyperPod cluster.
pub const ClusterLifeCycleConfig = struct {
    /// The file name of the entrypoint script of lifecycle scripts under
    /// `SourceS3Uri`. This entrypoint script runs during cluster creation.
    on_create: []const u8,

    /// An Amazon S3 bucket path where your lifecycle scripts are stored.
    ///
    /// Make sure that the S3 bucket path starts with `s3://sagemaker-`. The [IAM
    /// role for SageMaker
    /// HyperPod](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-hyperpod-prerequisites.html#sagemaker-hyperpod-prerequisites-iam-role-for-hyperpod) has the managed [ `AmazonSageMakerClusterInstanceRolePolicy` ](https://docs.aws.amazon.com/sagemaker/latest/dg/security-iam-awsmanpol-cluster.html) attached, which allows access to S3 buckets with the specific prefix `sagemaker-`.
    source_s3_uri: []const u8,

    pub const json_field_names = .{
        .on_create = "OnCreate",
        .source_s3_uri = "SourceS3Uri",
    };
};
