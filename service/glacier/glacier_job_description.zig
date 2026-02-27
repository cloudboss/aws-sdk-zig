const ActionCode = @import("action_code.zig").ActionCode;
const InventoryRetrievalJobDescription = @import("inventory_retrieval_job_description.zig").InventoryRetrievalJobDescription;
const OutputLocation = @import("output_location.zig").OutputLocation;
const SelectParameters = @import("select_parameters.zig").SelectParameters;
const StatusCode = @import("status_code.zig").StatusCode;

/// Contains the description of an Amazon S3 Glacier job.
pub const GlacierJobDescription = struct {
    /// The job type. This value is either `ArchiveRetrieval`,
    /// `InventoryRetrieval`, or
    /// `Select`.
    action: ?ActionCode,

    /// The archive ID requested for a select job or archive retrieval. Otherwise,
    /// this
    /// field is null.
    archive_id: ?[]const u8,

    /// The SHA256 tree hash of the entire archive for an archive retrieval. For
    /// inventory
    /// retrieval or select jobs, this field is null.
    archive_sha256_tree_hash: ?[]const u8,

    /// For an archive retrieval job, this value is the size in bytes of the archive
    /// being
    /// requested for download. For an inventory retrieval or select job, this value
    /// is
    /// null.
    archive_size_in_bytes: ?i64,

    /// The job status. When a job is completed, you get the job's output using Get
    /// Job
    /// Output (GET output).
    completed: bool = false,

    /// The UTC time that the job request completed. While the job is in progress,
    /// the
    /// value is null.
    completion_date: ?[]const u8,

    /// The UTC date when the job was created. This value is a string representation
    /// of ISO
    /// 8601 date format, for example `"2012-03-20T17:03:43.221Z"`.
    creation_date: ?[]const u8,

    /// Parameters used for range inventory retrieval.
    inventory_retrieval_parameters: ?InventoryRetrievalJobDescription,

    /// For an inventory retrieval job, this value is the size in bytes of the
    /// inventory
    /// requested for download. For an archive retrieval or select job, this value
    /// is
    /// null.
    inventory_size_in_bytes: ?i64,

    /// The job description provided when initiating the job.
    job_description: ?[]const u8,

    /// An opaque string that identifies an Amazon S3 Glacier job.
    job_id: ?[]const u8,

    /// Contains the job output location.
    job_output_path: ?[]const u8,

    /// Contains the location where the data from the select job is stored.
    output_location: ?OutputLocation,

    /// The retrieved byte range for archive retrieval jobs in the form
    /// *StartByteValue*-*EndByteValue*. If no range
    /// was specified in the archive retrieval, then the whole archive is retrieved.
    /// In this
    /// case, *StartByteValue* equals 0 and *EndByteValue*
    /// equals the size of the archive minus 1. For inventory retrieval or select
    /// jobs, this
    /// field is null.
    retrieval_byte_range: ?[]const u8,

    /// Contains the parameters used for a select.
    select_parameters: ?SelectParameters,

    /// For an archive retrieval job, this value is the checksum of the archive.
    /// Otherwise,
    /// this value is null.
    ///
    /// The SHA256 tree hash value for the requested range of an archive. If the
    /// **InitiateJob** request for an archive specified a tree-hash
    /// aligned range, then this field returns a value.
    ///
    /// If the whole archive is retrieved, this value is the same as the
    /// ArchiveSHA256TreeHash value.
    ///
    /// This field is null for the following:
    ///
    /// * Archive retrieval jobs that specify a range that is not tree-hash
    /// aligned
    ///
    /// * Archival jobs that specify a range that is equal to the whole archive,
    ///   when
    /// the job status is `InProgress`
    ///
    /// * Inventory jobs
    ///
    /// * Select jobs
    sha256_tree_hash: ?[]const u8,

    /// An Amazon SNS topic that receives notification.
    sns_topic: ?[]const u8,

    /// The status code can be `InProgress`, `Succeeded`, or
    /// `Failed`, and indicates the status of the job.
    status_code: ?StatusCode,

    /// A friendly message that describes the job status.
    status_message: ?[]const u8,

    /// The tier to use for a select or an archive retrieval. Valid values are
    /// `Expedited`, `Standard`, or `Bulk`.
    /// `Standard` is the default.
    tier: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the vault from which an archive retrieval
    /// was
    /// requested.
    vault_arn: ?[]const u8,

    pub const json_field_names = .{
        .action = "Action",
        .archive_id = "ArchiveId",
        .archive_sha256_tree_hash = "ArchiveSHA256TreeHash",
        .archive_size_in_bytes = "ArchiveSizeInBytes",
        .completed = "Completed",
        .completion_date = "CompletionDate",
        .creation_date = "CreationDate",
        .inventory_retrieval_parameters = "InventoryRetrievalParameters",
        .inventory_size_in_bytes = "InventorySizeInBytes",
        .job_description = "JobDescription",
        .job_id = "JobId",
        .job_output_path = "JobOutputPath",
        .output_location = "OutputLocation",
        .retrieval_byte_range = "RetrievalByteRange",
        .select_parameters = "SelectParameters",
        .sha256_tree_hash = "SHA256TreeHash",
        .sns_topic = "SNSTopic",
        .status_code = "StatusCode",
        .status_message = "StatusMessage",
        .tier = "Tier",
        .vault_arn = "VaultARN",
    };
};
