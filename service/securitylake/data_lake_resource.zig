const DataLakeStatus = @import("data_lake_status.zig").DataLakeStatus;
const DataLakeEncryptionConfiguration = @import("data_lake_encryption_configuration.zig").DataLakeEncryptionConfiguration;
const DataLakeLifecycleConfiguration = @import("data_lake_lifecycle_configuration.zig").DataLakeLifecycleConfiguration;
const DataLakeReplicationConfiguration = @import("data_lake_replication_configuration.zig").DataLakeReplicationConfiguration;
const DataLakeUpdateStatus = @import("data_lake_update_status.zig").DataLakeUpdateStatus;

/// Provides details of Amazon Security Lake object.
pub const DataLakeResource = struct {
    /// Retrieves the status of the `CreateDatalake` API call for an account in
    /// Amazon Security Lake.
    create_status: ?DataLakeStatus,

    /// The Amazon Resource Name (ARN) created by you to provide to the subscriber.
    /// For more information about ARNs and how to use them in policies, see the
    /// [Amazon Security Lake User
    /// Guide](https://docs.aws.amazon.com/security-lake/latest/userguide/subscriber-management.html).
    data_lake_arn: []const u8,

    /// Provides encryption details of Amazon Security Lake object.
    encryption_configuration: ?DataLakeEncryptionConfiguration,

    /// Provides lifecycle details of Amazon Security Lake object.
    lifecycle_configuration: ?DataLakeLifecycleConfiguration,

    /// The Amazon Web Services Regions where Security Lake is enabled.
    region: []const u8,

    /// Provides replication details of Amazon Security Lake object.
    replication_configuration: ?DataLakeReplicationConfiguration,

    /// The ARN for the Amazon Security Lake Amazon S3 bucket.
    s_3_bucket_arn: ?[]const u8,

    /// The status of the last `UpdateDataLake `or `DeleteDataLake` API
    /// request.
    update_status: ?DataLakeUpdateStatus,

    pub const json_field_names = .{
        .create_status = "createStatus",
        .data_lake_arn = "dataLakeArn",
        .encryption_configuration = "encryptionConfiguration",
        .lifecycle_configuration = "lifecycleConfiguration",
        .region = "region",
        .replication_configuration = "replicationConfiguration",
        .s_3_bucket_arn = "s3BucketArn",
        .update_status = "updateStatus",
    };
};
