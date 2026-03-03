const EncryptionKey = @import("encryption_key.zig").EncryptionKey;
const ParallelDataStatus = @import("parallel_data_status.zig").ParallelDataStatus;
const ParallelDataConfig = @import("parallel_data_config.zig").ParallelDataConfig;

/// The properties of a parallel data resource.
pub const ParallelDataProperties = struct {
    /// The Amazon Resource Name (ARN) of the parallel data resource.
    arn: ?[]const u8 = null,

    /// The time at which the parallel data resource was created.
    created_at: ?i64 = null,

    /// The description assigned to the parallel data resource.
    description: ?[]const u8 = null,

    encryption_key: ?EncryptionKey = null,

    /// The number of records unsuccessfully imported from the parallel data input
    /// file.
    failed_record_count: ?i64 = null,

    /// The number of UTF-8 characters that Amazon Translate imported from the
    /// parallel data input
    /// file. This number includes only the characters in your translation examples.
    /// It does not
    /// include characters that are used to format your file. For example, if you
    /// provided a
    /// Translation Memory Exchange (.tmx) file, this number does not include the
    /// tags.
    imported_data_size: ?i64 = null,

    /// The number of records successfully imported from the parallel data input
    /// file.
    imported_record_count: ?i64 = null,

    /// The time at which the parallel data resource was last updated.
    last_updated_at: ?i64 = null,

    /// The time that the most recent update was attempted.
    latest_update_attempt_at: ?i64 = null,

    /// The status of the most recent update attempt for the parallel data resource.
    latest_update_attempt_status: ?ParallelDataStatus = null,

    /// Additional information from Amazon Translate about the parallel data
    /// resource.
    message: ?[]const u8 = null,

    /// The custom name assigned to the parallel data resource.
    name: ?[]const u8 = null,

    /// Specifies the format and S3 location of the parallel data input file.
    parallel_data_config: ?ParallelDataConfig = null,

    /// The number of items in the input file that Amazon Translate skipped when you
    /// created or
    /// updated the parallel data resource. For example, Amazon Translate skips
    /// empty records, empty
    /// target texts, and empty lines.
    skipped_record_count: ?i64 = null,

    /// The source language of the translations in the parallel data file.
    source_language_code: ?[]const u8 = null,

    /// The status of the parallel data resource. When the parallel data is ready
    /// for you to use,
    /// the status is `ACTIVE`.
    status: ?ParallelDataStatus = null,

    /// The language codes for the target languages available in the parallel data
    /// file. All
    /// possible target languages are returned as an array.
    target_language_codes: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .description = "Description",
        .encryption_key = "EncryptionKey",
        .failed_record_count = "FailedRecordCount",
        .imported_data_size = "ImportedDataSize",
        .imported_record_count = "ImportedRecordCount",
        .last_updated_at = "LastUpdatedAt",
        .latest_update_attempt_at = "LatestUpdateAttemptAt",
        .latest_update_attempt_status = "LatestUpdateAttemptStatus",
        .message = "Message",
        .name = "Name",
        .parallel_data_config = "ParallelDataConfig",
        .skipped_record_count = "SkippedRecordCount",
        .source_language_code = "SourceLanguageCode",
        .status = "Status",
        .target_language_codes = "TargetLanguageCodes",
    };
};
