const S3Destination = @import("s3_destination.zig").S3Destination;

/// Specifies where to store data classification results, and the encryption
/// settings to use when storing results in that location. The location must be
/// an S3 general purpose bucket.
pub const ClassificationExportConfiguration = struct {
    /// The S3 bucket to store data classification results in, and the encryption
    /// settings to use when storing results in that bucket.
    s_3_destination: ?S3Destination = null,

    pub const json_field_names = .{
        .s_3_destination = "s3Destination",
    };
};
