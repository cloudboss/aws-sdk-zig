/// Specifies S3 configuration information for the input data for the data
/// ingestion job.
pub const IngestionS3InputConfiguration = struct {
    /// The name of the S3 bucket used for the input data for the data ingestion.
    bucket: []const u8,

    /// The pattern for matching the Amazon S3 files that will be used for
    /// ingestion.
    /// If the schema was created previously without any KeyPattern, then the
    /// default KeyPattern
    /// {prefix}/{component_name}/* is used to download files from Amazon S3
    /// according to
    /// the schema. This field is required when ingestion is being done for the
    /// first time.
    ///
    /// Valid Values: {prefix}/{component_name}_* | {prefix}/{component_name}/* |
    /// {prefix}/{component_name}[DELIMITER]* (Allowed delimiters : space, dot,
    /// underscore,
    /// hyphen)
    key_pattern: ?[]const u8,

    /// The prefix for the S3 location being used for the input data for the data
    /// ingestion.
    prefix: ?[]const u8,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .key_pattern = "KeyPattern",
        .prefix = "Prefix",
    };
};
