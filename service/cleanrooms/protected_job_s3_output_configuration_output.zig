/// The output configuration for a protected job's S3 output.
pub const ProtectedJobS3OutputConfigurationOutput = struct {
    /// The S3 bucket for job output.
    bucket: []const u8,

    /// The S3 prefix to unload the protected job results.
    key_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "bucket",
        .key_prefix = "keyPrefix",
    };
};
