const AutoImportPolicyType = @import("auto_import_policy_type.zig").AutoImportPolicyType;
const DataRepositoryFailureDetails = @import("data_repository_failure_details.zig").DataRepositoryFailureDetails;
const DataRepositoryLifecycle = @import("data_repository_lifecycle.zig").DataRepositoryLifecycle;

/// The data repository configuration object for Lustre file systems returned in
/// the response of
/// the `CreateFileSystem` operation.
///
/// This data type is not supported on file systems with a data repository
/// association.
/// For file systems with a data repository association,
/// see .
pub const DataRepositoryConfiguration = struct {
    /// Describes the file system's linked S3 data repository's `AutoImportPolicy`.
    /// The AutoImportPolicy configures how Amazon FSx keeps your file and directory
    /// listings up to date
    /// as you add or modify objects in your linked S3 bucket. `AutoImportPolicy`
    /// can have the following values:
    ///
    /// * `NONE` - (Default) AutoImport is off. Amazon FSx only updates
    /// file and directory listings from the linked S3 bucket
    /// when the file system is created. FSx does not update file and directory
    /// listings for any new or changed objects after choosing this option.
    ///
    /// * `NEW` - AutoImport is on. Amazon FSx automatically imports
    /// directory listings of any new objects added to the linked S3 bucket that
    /// do not currently exist in the FSx file system.
    ///
    /// * `NEW_CHANGED` - AutoImport is on. Amazon FSx automatically imports
    /// file and directory listings of any new objects added to the S3 bucket and
    /// any
    /// existing objects that are changed in the S3 bucket after you choose this
    /// option.
    ///
    /// * `NEW_CHANGED_DELETED` - AutoImport is on. Amazon FSx automatically
    /// imports file and directory listings of any new objects added to the S3
    /// bucket, any
    /// existing objects that are changed in the S3 bucket, and any objects that
    /// were deleted
    /// in the S3 bucket.
    auto_import_policy: ?AutoImportPolicyType = null,

    /// The export path to the Amazon S3 bucket (and prefix) that you are using to
    /// store new and
    /// changed Lustre file system files in S3.
    export_path: ?[]const u8 = null,

    failure_details: ?DataRepositoryFailureDetails = null,

    /// For files imported from a data repository, this value determines the stripe
    /// count and
    /// maximum amount of data per file (in MiB) stored on a single physical disk.
    /// The maximum
    /// number of disks that a single file can be striped across is limited by the
    /// total number
    /// of disks that make up the file system.
    ///
    /// The default chunk size is 1,024 MiB (1 GiB) and can go as high as 512,000
    /// MiB (500
    /// GiB). Amazon S3 objects have a maximum size of 5 TB.
    imported_file_chunk_size: ?i32 = null,

    /// The import path to the Amazon S3 bucket (and optional prefix) that you're
    /// using
    /// as the data repository for your FSx for Lustre file system, for example
    /// `s3://import-bucket/optional-prefix`. If a prefix is specified after the
    /// Amazon S3 bucket name, only object keys with that prefix are loaded into the
    /// file
    /// system.
    import_path: ?[]const u8 = null,

    /// Describes the state of the file system's S3 durable data repository, if it
    /// is configured with an S3 repository.
    /// The lifecycle can have the following values:
    ///
    /// * `CREATING` - The data repository configuration between
    /// the FSx file system and the linked S3 data repository is being created.
    /// The data repository is unavailable.
    ///
    /// * `AVAILABLE` - The data repository is available for use.
    ///
    /// * `MISCONFIGURED` - Amazon FSx cannot automatically import updates from the
    ///   S3 bucket
    /// until the data repository configuration is corrected. For more information,
    /// see
    /// [Troubleshooting a Misconfigured linked S3
    /// bucket](https://docs.aws.amazon.com/fsx/latest/LustreGuide/troubleshooting.html#troubleshooting-misconfigured-data-repository).
    ///
    /// * `UPDATING` - The data repository is undergoing a customer
    /// initiated update and availability may be impacted.
    ///
    /// * `FAILED` - The data repository is in a terminal state that
    /// cannot be recovered.
    lifecycle: ?DataRepositoryLifecycle = null,

    pub const json_field_names = .{
        .auto_import_policy = "AutoImportPolicy",
        .export_path = "ExportPath",
        .failure_details = "FailureDetails",
        .imported_file_chunk_size = "ImportedFileChunkSize",
        .import_path = "ImportPath",
        .lifecycle = "Lifecycle",
    };
};
