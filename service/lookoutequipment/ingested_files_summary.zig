const S3Object = @import("s3_object.zig").S3Object;

/// Gives statistics about how many files have been ingested, and which files
/// have not been
/// ingested, for a particular ingestion job.
pub const IngestedFilesSummary = struct {
    /// Indicates the number of files that were discarded. A file could be discarded
    /// because its
    /// format is invalid (for example, a jpg or pdf) or not readable.
    discarded_files: ?[]const S3Object,

    /// Indicates the number of files that were successfully ingested.
    ingested_number_of_files: i32,

    /// Indicates the total number of files that were submitted for ingestion.
    total_number_of_files: i32,

    pub const json_field_names = .{
        .discarded_files = "DiscardedFiles",
        .ingested_number_of_files = "IngestedNumberOfFiles",
        .total_number_of_files = "TotalNumberOfFiles",
    };
};
