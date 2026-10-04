const S3ObjectStorageMode = @import("s3_object_storage_mode.zig").S3ObjectStorageMode;

/// A ZIP archive that contains the contents of an [Lambda
/// layer](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html). You can specify either an Amazon S3 location, or upload a layer archive directly.
pub const LayerVersionContentInput = struct {
    /// The Amazon S3 bucket of the layer archive.
    s3_bucket: ?[]const u8 = null,

    /// The Amazon S3 key of the layer archive.
    s3_key: ?[]const u8 = null,

    /// Specifies how the layer archive is stored. Valid values:
    ///
    /// * `COPY` (default) – Uploads a copy of your layer archive to Lambda.
    /// * `REFERENCE` – Lambda references the layer archive from the specified
    ///   Amazon S3 bucket.
    s3_object_storage_mode: ?S3ObjectStorageMode = null,

    /// For versioned objects, the version of the layer archive object to use.
    s3_object_version: ?[]const u8 = null,

    /// The base64-encoded contents of the layer archive. Amazon Web Services SDK
    /// and Amazon Web Services CLI clients handle the encoding for you.
    zip_file: ?[]const u8 = null,

    pub const json_field_names = .{
        .s3_bucket = "S3Bucket",
        .s3_key = "S3Key",
        .s3_object_storage_mode = "S3ObjectStorageMode",
        .s3_object_version = "S3ObjectVersion",
        .zip_file = "ZipFile",
    };
};
