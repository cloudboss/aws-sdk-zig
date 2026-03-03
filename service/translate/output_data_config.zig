const EncryptionKey = @import("encryption_key.zig").EncryptionKey;

/// The output configuration properties for a batch translation job.
pub const OutputDataConfig = struct {
    encryption_key: ?EncryptionKey = null,

    /// The URI of the S3 folder that contains a translation job's output file. The
    /// folder must
    /// be in the same Region as the API endpoint that you are calling.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .encryption_key = "EncryptionKey",
        .s3_uri = "S3Uri",
    };
};
