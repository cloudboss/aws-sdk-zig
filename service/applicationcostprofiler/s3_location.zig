/// Represents the Amazon Simple Storage Service (Amazon S3) location where AWS
/// Application Cost Profiler
/// reports are generated and then written to.
pub const S3Location = struct {
    /// Name of the S3 bucket.
    bucket: []const u8,

    /// Prefix for the location to write to.
    prefix: []const u8,

    pub const json_field_names = .{
        .bucket = "bucket",
        .prefix = "prefix",
    };
};
