const S3Bucket = @import("s3_bucket.zig").S3Bucket;

/// Determines where recordings of RDP connections are stored.
pub const RecordingDestinations = struct {
    /// The S3 bucket where RDP connection recordings are stored.
    s3_buckets: []const S3Bucket,

    pub const json_field_names = .{
        .s3_buckets = "S3Buckets",
    };
};
