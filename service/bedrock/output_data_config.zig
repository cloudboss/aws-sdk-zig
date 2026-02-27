/// S3 Location of the output data.
pub const OutputDataConfig = struct {
    /// The S3 URI where the output data is stored.
    s_3_uri: []const u8,

    pub const json_field_names = .{
        .s_3_uri = "s3Uri",
    };
};
