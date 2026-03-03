const EncryptionKey = @import("encryption_key.zig").EncryptionKey;
const ArtifactStoreType = @import("artifact_store_type.zig").ArtifactStoreType;

/// The S3 bucket where artifacts for the pipeline are stored.
///
/// You must include either `artifactStore` or
/// `artifactStores` in your pipeline, but you cannot use both. If you
/// create a cross-region action in your pipeline, you must use
/// `artifactStores`.
pub const ArtifactStore = struct {
    /// The encryption key used to encrypt the data in the artifact store, such as
    /// an
    /// Amazon Web Services Key Management Service key. If this is undefined, the
    /// default key
    /// for Amazon S3 is used.
    encryption_key: ?EncryptionKey = null,

    /// The S3 bucket used for storing the artifacts for a pipeline. You can specify
    /// the
    /// name of an S3 bucket but not a folder in the bucket. A folder to contain the
    /// pipeline
    /// artifacts is created for you based on the name of the pipeline. You can use
    /// any S3
    /// bucket in the same Amazon Web Services Region as the pipeline to store your
    /// pipeline
    /// artifacts.
    location: []const u8,

    /// The type of the artifact store, such as S3.
    @"type": ArtifactStoreType,

    pub const json_field_names = .{
        .encryption_key = "encryptionKey",
        .location = "location",
        .@"type" = "type",
    };
};
