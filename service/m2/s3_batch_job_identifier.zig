const JobIdentifier = @import("job_identifier.zig").JobIdentifier;

/// A batch job identifier in which the batch jobs to run are identified by an
/// Amazon S3 location.
pub const S3BatchJobIdentifier = struct {
    /// The Amazon S3 bucket that contains the batch job definitions.
    bucket: []const u8,

    /// Identifies the batch job definition. This identifier can also point to any
    /// batch job definition that already exists in the application or to one of the
    /// batch job definitions within the directory that is specified in `keyPrefix`.
    identifier: JobIdentifier,

    /// The key prefix that specifies the path to the folder in the S3 bucket that
    /// has the batch job definitions.
    key_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "bucket",
        .identifier = "identifier",
        .key_prefix = "keyPrefix",
    };
};
