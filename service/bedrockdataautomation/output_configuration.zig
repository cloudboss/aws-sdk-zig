/// Output configuration for DataAutomationLibraryIngestionJob
pub const OutputConfiguration = struct {
    /// S3 Uri
    s_3_uri: []const u8,

    pub const json_field_names = .{
        .s_3_uri = "s3Uri",
    };
};
