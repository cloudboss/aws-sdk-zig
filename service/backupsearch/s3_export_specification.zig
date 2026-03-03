/// This specification contains a required string of the destination bucket;
/// optionally, you can include the destination prefix.
pub const S3ExportSpecification = struct {
    /// This specifies the destination Amazon S3 bucket for the export job.
    destination_bucket: []const u8,

    /// This specifies the prefix for the destination Amazon S3 bucket for the
    /// export job.
    destination_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination_bucket = "DestinationBucket",
        .destination_prefix = "DestinationPrefix",
    };
};
