/// The location of the Amazon S3 bucket that you specify to download your tax
/// documents to.
pub const DestinationS3Location = struct {
    /// The name of your Amazon S3 bucket that you specify to download your tax
    /// documents to.
    bucket: []const u8,

    /// The Amazon S3 object prefix that you specify for your tax document file.
    prefix: ?[]const u8,

    pub const json_field_names = .{
        .bucket = "bucket",
        .prefix = "prefix",
    };
};
