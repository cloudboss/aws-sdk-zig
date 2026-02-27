const ExportSourceType = @import("export_source_type.zig").ExportSourceType;

/// Contains the details of a snapshot or cluster export to Amazon S3.
///
/// This data type is used as a response element in the `DescribeExportTasks`
/// operation.
pub const ExportTask = struct {
    /// The data exported from the snapshot or cluster.
    ///
    /// Valid Values:
    ///
    /// * `database` - Export all the data from a specified database.
    /// * `database.table` *table-name* - Export a table of the snapshot or cluster.
    ///   This format is valid only for RDS for MySQL, RDS for MariaDB, and Aurora
    ///   MySQL.
    /// * `database.schema` *schema-name* - Export a database schema of the snapshot
    ///   or cluster. This format is valid only for RDS for PostgreSQL and Aurora
    ///   PostgreSQL.
    /// * `database.schema.table` *table-name* - Export a table of the database
    ///   schema. This format is valid only for RDS for PostgreSQL and Aurora
    ///   PostgreSQL.
    export_only: ?[]const []const u8,

    /// A unique identifier for the snapshot or cluster export task. This ID isn't
    /// an identifier for the Amazon S3 bucket where the data is exported.
    export_task_identifier: ?[]const u8,

    /// The reason the export failed, if it failed.
    failure_cause: ?[]const u8,

    /// The name of the IAM role that is used to write to Amazon S3 when exporting a
    /// snapshot or cluster.
    iam_role_arn: ?[]const u8,

    /// The key identifier of the Amazon Web Services KMS key that is used to
    /// encrypt the data when it's exported to Amazon S3. The KMS key identifier is
    /// its key ARN, key ID, alias ARN, or alias name. The IAM role used for the
    /// export must have encryption and decryption permissions to use this KMS key.
    kms_key_id: ?[]const u8,

    /// The progress of the snapshot or cluster export task as a percentage.
    percent_progress: ?i32,

    /// The Amazon S3 bucket where the snapshot or cluster is exported to.
    s3_bucket: ?[]const u8,

    /// The Amazon S3 bucket prefix that is the file name and path of the exported
    /// data.
    s3_prefix: ?[]const u8,

    /// The time when the snapshot was created.
    snapshot_time: ?i64,

    /// The Amazon Resource Name (ARN) of the snapshot or cluster exported to Amazon
    /// S3.
    source_arn: ?[]const u8,

    /// The type of source for the export.
    source_type: ?ExportSourceType,

    /// The progress status of the export task. The status can be one of the
    /// following:
    ///
    /// * `CANCELED`
    /// * `CANCELING`
    /// * `COMPLETE`
    /// * `FAILED`
    /// * `IN_PROGRESS`
    /// * `STARTING`
    status: ?[]const u8,

    /// The time when the snapshot or cluster export task ended.
    task_end_time: ?i64,

    /// The time when the snapshot or cluster export task started.
    task_start_time: ?i64,

    /// The total amount of data exported, in gigabytes.
    total_extracted_data_in_gb: ?i32,

    /// A warning about the snapshot or cluster export task.
    warning_message: ?[]const u8,
};
