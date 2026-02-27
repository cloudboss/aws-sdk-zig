const aws = @import("aws");
const std = @import("std");

const create_namespace = @import("create_namespace.zig");
const create_table = @import("create_table.zig");
const create_table_bucket = @import("create_table_bucket.zig");
const delete_namespace = @import("delete_namespace.zig");
const delete_table = @import("delete_table.zig");
const delete_table_bucket = @import("delete_table_bucket.zig");
const delete_table_bucket_encryption = @import("delete_table_bucket_encryption.zig");
const delete_table_bucket_metrics_configuration = @import("delete_table_bucket_metrics_configuration.zig");
const delete_table_bucket_policy = @import("delete_table_bucket_policy.zig");
const delete_table_bucket_replication = @import("delete_table_bucket_replication.zig");
const delete_table_policy = @import("delete_table_policy.zig");
const delete_table_replication = @import("delete_table_replication.zig");
const get_namespace = @import("get_namespace.zig");
const get_table = @import("get_table.zig");
const get_table_bucket = @import("get_table_bucket.zig");
const get_table_bucket_encryption = @import("get_table_bucket_encryption.zig");
const get_table_bucket_maintenance_configuration = @import("get_table_bucket_maintenance_configuration.zig");
const get_table_bucket_metrics_configuration = @import("get_table_bucket_metrics_configuration.zig");
const get_table_bucket_policy = @import("get_table_bucket_policy.zig");
const get_table_bucket_replication = @import("get_table_bucket_replication.zig");
const get_table_bucket_storage_class = @import("get_table_bucket_storage_class.zig");
const get_table_encryption = @import("get_table_encryption.zig");
const get_table_maintenance_configuration = @import("get_table_maintenance_configuration.zig");
const get_table_maintenance_job_status = @import("get_table_maintenance_job_status.zig");
const get_table_metadata_location = @import("get_table_metadata_location.zig");
const get_table_policy = @import("get_table_policy.zig");
const get_table_record_expiration_configuration = @import("get_table_record_expiration_configuration.zig");
const get_table_record_expiration_job_status = @import("get_table_record_expiration_job_status.zig");
const get_table_replication = @import("get_table_replication.zig");
const get_table_replication_status = @import("get_table_replication_status.zig");
const get_table_storage_class = @import("get_table_storage_class.zig");
const list_namespaces = @import("list_namespaces.zig");
const list_table_buckets = @import("list_table_buckets.zig");
const list_tables = @import("list_tables.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_table_bucket_encryption = @import("put_table_bucket_encryption.zig");
const put_table_bucket_maintenance_configuration = @import("put_table_bucket_maintenance_configuration.zig");
const put_table_bucket_metrics_configuration = @import("put_table_bucket_metrics_configuration.zig");
const put_table_bucket_policy = @import("put_table_bucket_policy.zig");
const put_table_bucket_replication = @import("put_table_bucket_replication.zig");
const put_table_bucket_storage_class = @import("put_table_bucket_storage_class.zig");
const put_table_maintenance_configuration = @import("put_table_maintenance_configuration.zig");
const put_table_policy = @import("put_table_policy.zig");
const put_table_record_expiration_configuration = @import("put_table_record_expiration_configuration.zig");
const put_table_replication = @import("put_table_replication.zig");
const rename_table = @import("rename_table.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_table_metadata_location = @import("update_table_metadata_location.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "S3Tables";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates a namespace. A namespace is a logical grouping of tables within your
    /// table bucket, which you can use to organize tables. For more information,
    /// see [Create a
    /// namespace](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-namespace-create.html) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:CreateNamespace` permission to use this
    /// operation.
    pub fn createNamespace(self: *Self, allocator: std.mem.Allocator, input: create_namespace.CreateNamespaceInput, options: create_namespace.Options) !create_namespace.CreateNamespaceOutput {
        return create_namespace.execute(self, allocator, input, options);
    }

    /// Creates a new table associated with the given namespace in a table bucket.
    /// For more information, see [Creating an Amazon S3
    /// table](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-create.html) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// * You must have the `s3tables:CreateTable` permission to use this operation.
    /// * If you use this operation with the optional `metadata` request parameter
    ///   you must have the `s3tables:PutTableData` permission.
    /// * If you use this operation with the optional `encryptionConfiguration`
    ///   request parameter you must have the `s3tables:PutTableEncryption`
    ///   permission.
    /// * If you use this operation with the `storageClassConfiguration` request
    ///   parameter, you must have the `s3tables:PutTableStorageClass` permission.
    /// * To create a table with tags, you must have the `s3tables:TagResource`
    ///   permission in addition to `s3tables:CreateTable` permission.
    ///
    /// Additionally, If you choose SSE-KMS encryption you must grant the S3 Tables
    /// maintenance principal access to your KMS key. For more information, see
    /// [Permissions requirements for S3 Tables SSE-KMS
    /// encryption](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-kms-permissions.html).
    pub fn createTable(self: *Self, allocator: std.mem.Allocator, input: create_table.CreateTableInput, options: create_table.Options) !create_table.CreateTableOutput {
        return create_table.execute(self, allocator, input, options);
    }

    /// Creates a table bucket. For more information, see [Creating a table
    /// bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-buckets-create.html) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// * You must have the `s3tables:CreateTableBucket` permission to use this
    ///   operation.
    /// * If you use this operation with the optional `encryptionConfiguration`
    ///   parameter you must have the `s3tables:PutTableBucketEncryption`
    ///   permission.
    /// * If you use this operation with the `storageClassConfiguration` request
    ///   parameter, you must have the `s3tables:PutTableBucketStorageClass`
    ///   permission.
    /// * To create a table bucket with tags, you must have the
    ///   `s3tables:TagResource` permission in addition to
    ///   `s3tables:CreateTableBucket` permission.
    pub fn createTableBucket(self: *Self, allocator: std.mem.Allocator, input: create_table_bucket.CreateTableBucketInput, options: create_table_bucket.Options) !create_table_bucket.CreateTableBucketOutput {
        return create_table_bucket.execute(self, allocator, input, options);
    }

    /// Deletes a namespace. For more information, see [Delete a
    /// namespace](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-namespace-delete.html) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:DeleteNamespace` permission to use this
    /// operation.
    pub fn deleteNamespace(self: *Self, allocator: std.mem.Allocator, input: delete_namespace.DeleteNamespaceInput, options: delete_namespace.Options) !delete_namespace.DeleteNamespaceOutput {
        return delete_namespace.execute(self, allocator, input, options);
    }

    /// Deletes a table. For more information, see [Deleting an Amazon S3
    /// table](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-delete.html) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:DeleteTable` permission to use this operation.
    pub fn deleteTable(self: *Self, allocator: std.mem.Allocator, input: delete_table.DeleteTableInput, options: delete_table.Options) !delete_table.DeleteTableOutput {
        return delete_table.execute(self, allocator, input, options);
    }

    /// Deletes a table bucket. For more information, see [Deleting a table
    /// bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-buckets-delete.html) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:DeleteTableBucket` permission to use this
    /// operation.
    pub fn deleteTableBucket(self: *Self, allocator: std.mem.Allocator, input: delete_table_bucket.DeleteTableBucketInput, options: delete_table_bucket.Options) !delete_table_bucket.DeleteTableBucketOutput {
        return delete_table_bucket.execute(self, allocator, input, options);
    }

    /// Deletes the encryption configuration for a table bucket.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:DeleteTableBucketEncryption` permission to use
    /// this operation.
    pub fn deleteTableBucketEncryption(self: *Self, allocator: std.mem.Allocator, input: delete_table_bucket_encryption.DeleteTableBucketEncryptionInput, options: delete_table_bucket_encryption.Options) !delete_table_bucket_encryption.DeleteTableBucketEncryptionOutput {
        return delete_table_bucket_encryption.execute(self, allocator, input, options);
    }

    /// Deletes the metrics configuration for a table bucket.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:DeleteTableBucketMetricsConfiguration`
    /// permission to use this operation.
    pub fn deleteTableBucketMetricsConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_table_bucket_metrics_configuration.DeleteTableBucketMetricsConfigurationInput, options: delete_table_bucket_metrics_configuration.Options) !delete_table_bucket_metrics_configuration.DeleteTableBucketMetricsConfigurationOutput {
        return delete_table_bucket_metrics_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a table bucket policy. For more information, see [Deleting a table
    /// bucket
    /// policy](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-bucket-policy.html#table-bucket-policy-delete) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:DeleteTableBucketPolicy` permission to use this
    /// operation.
    pub fn deleteTableBucketPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_table_bucket_policy.DeleteTableBucketPolicyInput, options: delete_table_bucket_policy.Options) !delete_table_bucket_policy.DeleteTableBucketPolicyOutput {
        return delete_table_bucket_policy.execute(self, allocator, input, options);
    }

    /// Deletes the replication configuration for a table bucket. After deletion,
    /// new table updates will no longer be replicated to destination buckets,
    /// though existing replicated tables will remain in destination buckets.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:DeleteTableBucketReplication` permission to use
    /// this operation.
    pub fn deleteTableBucketReplication(self: *Self, allocator: std.mem.Allocator, input: delete_table_bucket_replication.DeleteTableBucketReplicationInput, options: delete_table_bucket_replication.Options) !delete_table_bucket_replication.DeleteTableBucketReplicationOutput {
        return delete_table_bucket_replication.execute(self, allocator, input, options);
    }

    /// Deletes a table policy. For more information, see [Deleting a table
    /// policy](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-table-policy.html#table-policy-delete) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:DeleteTablePolicy` permission to use this
    /// operation.
    pub fn deleteTablePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_table_policy.DeleteTablePolicyInput, options: delete_table_policy.Options) !delete_table_policy.DeleteTablePolicyOutput {
        return delete_table_policy.execute(self, allocator, input, options);
    }

    /// Deletes the replication configuration for a specific table. After deletion,
    /// new updates to this table will no longer be replicated to destination
    /// tables, though existing replicated copies will remain in destination
    /// buckets.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:DeleteTableReplication` permission to use this
    /// operation.
    pub fn deleteTableReplication(self: *Self, allocator: std.mem.Allocator, input: delete_table_replication.DeleteTableReplicationInput, options: delete_table_replication.Options) !delete_table_replication.DeleteTableReplicationOutput {
        return delete_table_replication.execute(self, allocator, input, options);
    }

    /// Gets details about a namespace. For more information, see [Table
    /// namespaces](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-namespace.html) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:GetNamespace` permission to use this operation.
    pub fn getNamespace(self: *Self, allocator: std.mem.Allocator, input: get_namespace.GetNamespaceInput, options: get_namespace.Options) !get_namespace.GetNamespaceOutput {
        return get_namespace.execute(self, allocator, input, options);
    }

    /// Gets details about a table. For more information, see [S3
    /// Tables](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-tables.html) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:GetTable` permission to use this operation.
    pub fn getTable(self: *Self, allocator: std.mem.Allocator, input: get_table.GetTableInput, options: get_table.Options) !get_table.GetTableOutput {
        return get_table.execute(self, allocator, input, options);
    }

    /// Gets details on a table bucket. For more information, see [Viewing details
    /// about an Amazon S3 table
    /// bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-buckets-details.html) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:GetTableBucket` permission to use this
    /// operation.
    pub fn getTableBucket(self: *Self, allocator: std.mem.Allocator, input: get_table_bucket.GetTableBucketInput, options: get_table_bucket.Options) !get_table_bucket.GetTableBucketOutput {
        return get_table_bucket.execute(self, allocator, input, options);
    }

    /// Gets the encryption configuration for a table bucket.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:GetTableBucketEncryption` permission to use this
    /// operation.
    pub fn getTableBucketEncryption(self: *Self, allocator: std.mem.Allocator, input: get_table_bucket_encryption.GetTableBucketEncryptionInput, options: get_table_bucket_encryption.Options) !get_table_bucket_encryption.GetTableBucketEncryptionOutput {
        return get_table_bucket_encryption.execute(self, allocator, input, options);
    }

    /// Gets details about a maintenance configuration for a given table bucket. For
    /// more information, see [Amazon S3 table bucket
    /// maintenance](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-table-buckets-maintenance.html) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:GetTableBucketMaintenanceConfiguration`
    /// permission to use this operation.
    pub fn getTableBucketMaintenanceConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_table_bucket_maintenance_configuration.GetTableBucketMaintenanceConfigurationInput, options: get_table_bucket_maintenance_configuration.Options) !get_table_bucket_maintenance_configuration.GetTableBucketMaintenanceConfigurationOutput {
        return get_table_bucket_maintenance_configuration.execute(self, allocator, input, options);
    }

    /// Gets the metrics configuration for a table bucket.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:GetTableBucketMetricsConfiguration` permission
    /// to use this operation.
    pub fn getTableBucketMetricsConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_table_bucket_metrics_configuration.GetTableBucketMetricsConfigurationInput, options: get_table_bucket_metrics_configuration.Options) !get_table_bucket_metrics_configuration.GetTableBucketMetricsConfigurationOutput {
        return get_table_bucket_metrics_configuration.execute(self, allocator, input, options);
    }

    /// Gets details about a table bucket policy. For more information, see [Viewing
    /// a table bucket
    /// policy](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-bucket-policy.html#table-bucket-policy-get) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:GetTableBucketPolicy` permission to use this
    /// operation.
    pub fn getTableBucketPolicy(self: *Self, allocator: std.mem.Allocator, input: get_table_bucket_policy.GetTableBucketPolicyInput, options: get_table_bucket_policy.Options) !get_table_bucket_policy.GetTableBucketPolicyOutput {
        return get_table_bucket_policy.execute(self, allocator, input, options);
    }

    /// Retrieves the replication configuration for a table bucket.This operation
    /// returns the IAM role, `versionToken`, and replication rules that define how
    /// tables in this bucket are replicated to other buckets.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:GetTableBucketReplication` permission to use
    /// this operation.
    pub fn getTableBucketReplication(self: *Self, allocator: std.mem.Allocator, input: get_table_bucket_replication.GetTableBucketReplicationInput, options: get_table_bucket_replication.Options) !get_table_bucket_replication.GetTableBucketReplicationOutput {
        return get_table_bucket_replication.execute(self, allocator, input, options);
    }

    /// Retrieves the storage class configuration for a specific table. This allows
    /// you to view the storage class settings that apply to an individual table,
    /// which may differ from the table bucket's default configuration.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:GetTableBucketStorageClass` permission to use
    /// this operation.
    pub fn getTableBucketStorageClass(self: *Self, allocator: std.mem.Allocator, input: get_table_bucket_storage_class.GetTableBucketStorageClassInput, options: get_table_bucket_storage_class.Options) !get_table_bucket_storage_class.GetTableBucketStorageClassOutput {
        return get_table_bucket_storage_class.execute(self, allocator, input, options);
    }

    /// Gets the encryption configuration for a table.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:GetTableEncryption` permission to use this
    /// operation.
    pub fn getTableEncryption(self: *Self, allocator: std.mem.Allocator, input: get_table_encryption.GetTableEncryptionInput, options: get_table_encryption.Options) !get_table_encryption.GetTableEncryptionOutput {
        return get_table_encryption.execute(self, allocator, input, options);
    }

    /// Gets details about the maintenance configuration of a table. For more
    /// information, see [S3 Tables
    /// maintenance](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-maintenance.html) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// * You must have the `s3tables:GetTableMaintenanceConfiguration` permission
    ///   to use this operation.
    /// * You must have the `s3tables:GetTableData` permission to use set the
    ///   compaction strategy to `sort` or `zorder`.
    pub fn getTableMaintenanceConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_table_maintenance_configuration.GetTableMaintenanceConfigurationInput, options: get_table_maintenance_configuration.Options) !get_table_maintenance_configuration.GetTableMaintenanceConfigurationOutput {
        return get_table_maintenance_configuration.execute(self, allocator, input, options);
    }

    /// Gets the status of a maintenance job for a table. For more information, see
    /// [S3 Tables
    /// maintenance](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-maintenance.html) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:GetTableMaintenanceJobStatus` permission to use
    /// this operation.
    pub fn getTableMaintenanceJobStatus(self: *Self, allocator: std.mem.Allocator, input: get_table_maintenance_job_status.GetTableMaintenanceJobStatusInput, options: get_table_maintenance_job_status.Options) !get_table_maintenance_job_status.GetTableMaintenanceJobStatusOutput {
        return get_table_maintenance_job_status.execute(self, allocator, input, options);
    }

    /// Gets the location of the table metadata.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:GetTableMetadataLocation` permission to use this
    /// operation.
    pub fn getTableMetadataLocation(self: *Self, allocator: std.mem.Allocator, input: get_table_metadata_location.GetTableMetadataLocationInput, options: get_table_metadata_location.Options) !get_table_metadata_location.GetTableMetadataLocationOutput {
        return get_table_metadata_location.execute(self, allocator, input, options);
    }

    /// Gets details about a table policy. For more information, see [Viewing a
    /// table
    /// policy](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-table-policy.html#table-policy-get) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:GetTablePolicy` permission to use this
    /// operation.
    pub fn getTablePolicy(self: *Self, allocator: std.mem.Allocator, input: get_table_policy.GetTablePolicyInput, options: get_table_policy.Options) !get_table_policy.GetTablePolicyOutput {
        return get_table_policy.execute(self, allocator, input, options);
    }

    /// Retrieves the expiration configuration settings for records in a table, and
    /// the status of the configuration. If the status of the configuration is
    /// `enabled`, records expire and are automatically removed from the table after
    /// the specified number of days.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:GetTableRecordExpirationConfiguration`
    /// permission to use this operation.
    pub fn getTableRecordExpirationConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_table_record_expiration_configuration.GetTableRecordExpirationConfigurationInput, options: get_table_record_expiration_configuration.Options) !get_table_record_expiration_configuration.GetTableRecordExpirationConfigurationOutput {
        return get_table_record_expiration_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves the status, metrics, and details of the latest record expiration
    /// job for a table. This includes when the job ran, and whether it succeeded or
    /// failed. If the job ran successfully, this also includes statistics about the
    /// records that were removed.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:GetTableRecordExpirationJobStatus` permission to
    /// use this operation.
    pub fn getTableRecordExpirationJobStatus(self: *Self, allocator: std.mem.Allocator, input: get_table_record_expiration_job_status.GetTableRecordExpirationJobStatusInput, options: get_table_record_expiration_job_status.Options) !get_table_record_expiration_job_status.GetTableRecordExpirationJobStatusOutput {
        return get_table_record_expiration_job_status.execute(self, allocator, input, options);
    }

    /// Retrieves the replication configuration for a specific table.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:GetTableReplication` permission to use this
    /// operation.
    pub fn getTableReplication(self: *Self, allocator: std.mem.Allocator, input: get_table_replication.GetTableReplicationInput, options: get_table_replication.Options) !get_table_replication.GetTableReplicationOutput {
        return get_table_replication.execute(self, allocator, input, options);
    }

    /// Retrieves the replication status for a table, including the status of
    /// replication to each destination. This operation provides visibility into
    /// replication health and progress.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:GetTableReplicationStatus` permission to use
    /// this operation.
    pub fn getTableReplicationStatus(self: *Self, allocator: std.mem.Allocator, input: get_table_replication_status.GetTableReplicationStatusInput, options: get_table_replication_status.Options) !get_table_replication_status.GetTableReplicationStatusOutput {
        return get_table_replication_status.execute(self, allocator, input, options);
    }

    /// Retrieves the storage class configuration for a specific table. This allows
    /// you to view the storage class settings that apply to an individual table,
    /// which may differ from the table bucket's default configuration.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:GetTableStorageClass` permission to use this
    /// operation.
    pub fn getTableStorageClass(self: *Self, allocator: std.mem.Allocator, input: get_table_storage_class.GetTableStorageClassInput, options: get_table_storage_class.Options) !get_table_storage_class.GetTableStorageClassOutput {
        return get_table_storage_class.execute(self, allocator, input, options);
    }

    /// Lists the namespaces within a table bucket. For more information, see [Table
    /// namespaces](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-namespace.html) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:ListNamespaces` permission to use this
    /// operation.
    pub fn listNamespaces(self: *Self, allocator: std.mem.Allocator, input: list_namespaces.ListNamespacesInput, options: list_namespaces.Options) !list_namespaces.ListNamespacesOutput {
        return list_namespaces.execute(self, allocator, input, options);
    }

    /// Lists table buckets for your account. For more information, see [S3 Table
    /// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-buckets.html) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:ListTableBuckets` permission to use this
    /// operation.
    pub fn listTableBuckets(self: *Self, allocator: std.mem.Allocator, input: list_table_buckets.ListTableBucketsInput, options: list_table_buckets.Options) !list_table_buckets.ListTableBucketsOutput {
        return list_table_buckets.execute(self, allocator, input, options);
    }

    /// List tables in the given table bucket. For more information, see [S3
    /// Tables](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-tables.html) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:ListTables` permission to use this operation.
    pub fn listTables(self: *Self, allocator: std.mem.Allocator, input: list_tables.ListTablesInput, options: list_tables.Options) !list_tables.ListTablesOutput {
        return list_tables.execute(self, allocator, input, options);
    }

    /// Lists all of the tags applied to a specified Amazon S3 Tables resource. Each
    /// tag is a label consisting of a key and value pair. Tags can help you
    /// organize, track costs for, and control access to resources.
    ///
    /// For a list of S3 resources that support tagging, see [Managing tags for
    /// Amazon S3
    /// resources](https://docs.aws.amazon.com/AmazonS3/latest/userguide/tagging.html#manage-tags).
    ///
    /// **Permissions**
    ///
    /// For tables and table buckets, you must have the
    /// `s3tables:ListTagsForResource` permission to use this operation.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Sets the encryption configuration for a table bucket.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:PutTableBucketEncryption` permission to use this
    /// operation.
    ///
    /// If you choose SSE-KMS encryption you must grant the S3 Tables maintenance
    /// principal access to your KMS key. For more information, see [Permissions
    /// requirements for S3 Tables SSE-KMS
    /// encryption](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-kms-permissions.html) in the *Amazon Simple Storage Service User Guide*.
    pub fn putTableBucketEncryption(self: *Self, allocator: std.mem.Allocator, input: put_table_bucket_encryption.PutTableBucketEncryptionInput, options: put_table_bucket_encryption.Options) !put_table_bucket_encryption.PutTableBucketEncryptionOutput {
        return put_table_bucket_encryption.execute(self, allocator, input, options);
    }

    /// Creates a new maintenance configuration or replaces an existing maintenance
    /// configuration for a table bucket. For more information, see [Amazon S3 table
    /// bucket
    /// maintenance](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-table-buckets-maintenance.html) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:PutTableBucketMaintenanceConfiguration`
    /// permission to use this operation.
    pub fn putTableBucketMaintenanceConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_table_bucket_maintenance_configuration.PutTableBucketMaintenanceConfigurationInput, options: put_table_bucket_maintenance_configuration.Options) !put_table_bucket_maintenance_configuration.PutTableBucketMaintenanceConfigurationOutput {
        return put_table_bucket_maintenance_configuration.execute(self, allocator, input, options);
    }

    /// Sets the metrics configuration for a table bucket.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:PutTableBucketMetricsConfiguration` permission
    /// to use this operation.
    pub fn putTableBucketMetricsConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_table_bucket_metrics_configuration.PutTableBucketMetricsConfigurationInput, options: put_table_bucket_metrics_configuration.Options) !put_table_bucket_metrics_configuration.PutTableBucketMetricsConfigurationOutput {
        return put_table_bucket_metrics_configuration.execute(self, allocator, input, options);
    }

    /// Creates a new table bucket policy or replaces an existing table bucket
    /// policy for a table bucket. For more information, see [Adding a table bucket
    /// policy](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-bucket-policy.html#table-bucket-policy-add) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:PutTableBucketPolicy` permission to use this
    /// operation.
    pub fn putTableBucketPolicy(self: *Self, allocator: std.mem.Allocator, input: put_table_bucket_policy.PutTableBucketPolicyInput, options: put_table_bucket_policy.Options) !put_table_bucket_policy.PutTableBucketPolicyOutput {
        return put_table_bucket_policy.execute(self, allocator, input, options);
    }

    /// Creates or updates the replication configuration for a table bucket. This
    /// operation defines how tables in the source bucket are replicated to
    /// destination buckets. Replication helps ensure data availability and disaster
    /// recovery across regions or accounts.
    ///
    /// **Permissions**
    ///
    /// * You must have the `s3tables:PutTableBucketReplication` permission to use
    ///   this operation. The IAM role specified in the configuration must have
    ///   permissions to read from the source bucket and write permissions to all
    ///   destination buckets.
    /// * You must also have the following permissions:
    ///
    /// * `s3tables:GetTable` permission on the source table.
    /// * `s3tables:ListTables` permission on the bucket containing the table.
    /// * `s3tables:CreateTable` permission for the destination.
    /// * `s3tables:CreateNamespace` permission for the destination.
    /// * `s3tables:GetTableMaintenanceConfig` permission for the source bucket.
    /// * `s3tables:PutTableMaintenanceConfig` permission for the destination
    ///   bucket.
    ///
    /// * You must have `iam:PassRole` permission with condition allowing roles to
    ///   be passed to `replication.s3tables.amazonaws.com`.
    pub fn putTableBucketReplication(self: *Self, allocator: std.mem.Allocator, input: put_table_bucket_replication.PutTableBucketReplicationInput, options: put_table_bucket_replication.Options) !put_table_bucket_replication.PutTableBucketReplicationOutput {
        return put_table_bucket_replication.execute(self, allocator, input, options);
    }

    /// Sets or updates the storage class configuration for a table bucket. This
    /// configuration serves as the default storage class for all new tables created
    /// in the bucket, allowing you to optimize storage costs at the bucket level.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:PutTableBucketStorageClass` permission to use
    /// this operation.
    pub fn putTableBucketStorageClass(self: *Self, allocator: std.mem.Allocator, input: put_table_bucket_storage_class.PutTableBucketStorageClassInput, options: put_table_bucket_storage_class.Options) !put_table_bucket_storage_class.PutTableBucketStorageClassOutput {
        return put_table_bucket_storage_class.execute(self, allocator, input, options);
    }

    /// Creates a new maintenance configuration or replaces an existing maintenance
    /// configuration for a table. For more information, see [S3 Tables
    /// maintenance](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-maintenance.html) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:PutTableMaintenanceConfiguration` permission to
    /// use this operation.
    pub fn putTableMaintenanceConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_table_maintenance_configuration.PutTableMaintenanceConfigurationInput, options: put_table_maintenance_configuration.Options) !put_table_maintenance_configuration.PutTableMaintenanceConfigurationOutput {
        return put_table_maintenance_configuration.execute(self, allocator, input, options);
    }

    /// Creates a new table policy or replaces an existing table policy for a table.
    /// For more information, see [Adding a table
    /// policy](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-table-policy.html#table-policy-add) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:PutTablePolicy` permission to use this
    /// operation.
    pub fn putTablePolicy(self: *Self, allocator: std.mem.Allocator, input: put_table_policy.PutTablePolicyInput, options: put_table_policy.Options) !put_table_policy.PutTablePolicyOutput {
        return put_table_policy.execute(self, allocator, input, options);
    }

    /// Creates or updates the expiration configuration settings for records in a
    /// table, including the status of the configuration. If you enable record
    /// expiration for a table, records expire and are automatically removed from
    /// the table after the number of days that you specify.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:PutTableRecordExpirationConfiguration`
    /// permission to use this operation.
    pub fn putTableRecordExpirationConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_table_record_expiration_configuration.PutTableRecordExpirationConfigurationInput, options: put_table_record_expiration_configuration.Options) !put_table_record_expiration_configuration.PutTableRecordExpirationConfigurationOutput {
        return put_table_record_expiration_configuration.execute(self, allocator, input, options);
    }

    /// Creates or updates the replication configuration for a specific table. This
    /// operation allows you to define table-level replication independently of
    /// bucket-level replication, providing granular control over which tables are
    /// replicated and where.
    ///
    /// **Permissions**
    ///
    /// * You must have the `s3tables:PutTableReplication` permission to use this
    ///   operation. The IAM role specified in the configuration must have
    ///   permissions to read from the source table and write to all destination
    ///   tables.
    /// * You must also have the following permissions:
    ///
    /// * `s3tables:GetTable` permission on the source table being replicated.
    /// * `s3tables:CreateTable` permission for the destination.
    /// * `s3tables:CreateNamespace` permission for the destination.
    /// * `s3tables:GetTableMaintenanceConfig` permission for the source table.
    /// * `s3tables:PutTableMaintenanceConfig` permission for the destination table.
    ///
    /// * You must have `iam:PassRole` permission with condition allowing roles to
    ///   be passed to `replication.s3tables.amazonaws.com`.
    pub fn putTableReplication(self: *Self, allocator: std.mem.Allocator, input: put_table_replication.PutTableReplicationInput, options: put_table_replication.Options) !put_table_replication.PutTableReplicationOutput {
        return put_table_replication.execute(self, allocator, input, options);
    }

    /// Renames a table or a namespace. For more information, see [S3
    /// Tables](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-tables.html) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:RenameTable` permission to use this operation.
    pub fn renameTable(self: *Self, allocator: std.mem.Allocator, input: rename_table.RenameTableInput, options: rename_table.Options) !rename_table.RenameTableOutput {
        return rename_table.execute(self, allocator, input, options);
    }

    /// Applies one or more user-defined tags to an Amazon S3 Tables resource or
    /// updates existing tags. Each tag is a label consisting of a key and value
    /// pair. Tags can help you organize, track costs for, and control access to
    /// your resources. You can add up to 50 tags for each S3 resource.
    ///
    /// For a list of S3 resources that support tagging, see [Managing tags for
    /// Amazon S3
    /// resources](https://docs.aws.amazon.com/AmazonS3/latest/userguide/tagging.html#manage-tags).
    ///
    /// **Permissions**
    ///
    /// For tables and table buckets, you must have the `s3tables:TagResource`
    /// permission to use this operation.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified user-defined tags from an Amazon S3 Tables resource.
    /// You can pass one or more tag keys.
    ///
    /// For a list of S3 resources that support tagging, see [Managing tags for
    /// Amazon S3
    /// resources](https://docs.aws.amazon.com/AmazonS3/latest/userguide/tagging.html#manage-tags).
    ///
    /// **Permissions**
    ///
    /// For tables and table buckets, you must have the `s3tables:UntagResource`
    /// permission to use this operation.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the metadata location for a table. The metadata location of a table
    /// must be an S3 URI that begins with the table's warehouse location. The
    /// metadata location for an Apache Iceberg table must end with
    /// `.metadata.json`, or if the metadata file is Gzip-compressed,
    /// `.metadata.json.gz`.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3tables:UpdateTableMetadataLocation` permission to use
    /// this operation.
    pub fn updateTableMetadataLocation(self: *Self, allocator: std.mem.Allocator, input: update_table_metadata_location.UpdateTableMetadataLocationInput, options: update_table_metadata_location.Options) !update_table_metadata_location.UpdateTableMetadataLocationOutput {
        return update_table_metadata_location.execute(self, allocator, input, options);
    }

    pub fn listNamespacesPaginator(self: *Self, params: list_namespaces.ListNamespacesInput) paginator.ListNamespacesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTableBucketsPaginator(self: *Self, params: list_table_buckets.ListTableBucketsInput) paginator.ListTableBucketsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTablesPaginator(self: *Self, params: list_tables.ListTablesInput) paginator.ListTablesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
