/// The configuration for exporting email data to an Amazon S3 bucket.
pub const S3ExportDestinationConfiguration = struct {
    /// The S3 location to deliver the exported email data.
    s3_location: ?[]const u8,

    pub const json_field_names = .{
        .s3_location = "S3Location",
    };
};
