/// The S3 URI for each read set file.
pub const ReadSetS3Access = struct {
    /// The S3 URI for each read set file.
    s_3_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .s_3_uri = "s3Uri",
    };
};
