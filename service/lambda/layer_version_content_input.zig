/// A ZIP archive that contains the contents of an [Lambda
/// layer](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html). You can specify either an Amazon S3 location, or upload a layer archive directly.
pub const LayerVersionContentInput = struct {
    /// The Amazon S3 bucket of the layer archive.
    s_3_bucket: ?[]const u8,

    /// The Amazon S3 key of the layer archive.
    s_3_key: ?[]const u8,

    /// For versioned objects, the version of the layer archive object to use.
    s_3_object_version: ?[]const u8,

    /// The base64-encoded contents of the layer archive. Amazon Web Services SDK
    /// and Amazon Web Services CLI clients handle the encoding for you.
    zip_file: ?[]const u8,
};
