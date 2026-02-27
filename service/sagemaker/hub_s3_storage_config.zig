/// The Amazon S3 storage configuration of a hub.
pub const HubS3StorageConfig = struct {
    /// The Amazon S3 bucket prefix for hosting hub content.
    s3_output_path: ?[]const u8,

    pub const json_field_names = .{
        .s3_output_path = "S3OutputPath",
    };
};
