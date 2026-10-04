/// Contains output information for an analysis log export with an S3 output
/// type.
///
/// The exported logs are written under the bucket and key prefix that you
/// specify. The path includes the collaboration ID, the protected query ID, and
/// the analysis log export ID. Because the path includes the export ID,
/// exporting the same query more than once doesn't overwrite the logs from an
/// earlier export.
///
/// The exported logs are encrypted using the default encryption configuration
/// of the destination bucket. Clean Rooms doesn't accept a KMS key for log
/// export. To encrypt the exported logs with a customer managed key, configure
/// the bucket's default encryption to use that key before you export.
pub const AnalysisLogExportS3OutputConfiguration = struct {
    /// The S3 bucket that the exported analysis logs are written to. The bucket
    /// must be in the same Amazon Web Services Region as the collaboration.
    bucket: []const u8,

    /// The S3 key prefix under which the exported analysis logs are written.
    ///
    /// Only one export can be in progress at a time for a given query and
    /// destination. To export the same query twice at once, use a different key
    /// prefix for the second export.
    key_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "bucket",
        .key_prefix = "keyPrefix",
    };
};
