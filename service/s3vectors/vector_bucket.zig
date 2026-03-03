const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;

/// The attributes of a vector bucket.
pub const VectorBucket = struct {
    /// Date and time when the vector bucket was created.
    creation_time: i64,

    /// The encryption configuration for the vector bucket.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// The Amazon Resource Name (ARN) of the vector bucket.
    vector_bucket_arn: []const u8,

    /// The name of the vector bucket.
    vector_bucket_name: []const u8,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .encryption_configuration = "encryptionConfiguration",
        .vector_bucket_arn = "vectorBucketArn",
        .vector_bucket_name = "vectorBucketName",
    };
};
