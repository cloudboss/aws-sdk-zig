/// Details about an Amazon S3 object.
pub const AwsS3ObjectDetails = struct {
    /// A standard MIME type describing the format of the object data.
    content_type: ?[]const u8 = null,

    /// The opaque identifier assigned by a web server to a specific version of a
    /// resource found
    /// at a URL.
    e_tag: ?[]const u8 = null,

    /// Indicates when the object was last modified.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    last_modified: ?[]const u8 = null,

    /// If the object is stored using server-side encryption, the value of the
    /// server-side
    /// encryption algorithm used when storing this object in Amazon S3.
    server_side_encryption: ?[]const u8 = null,

    /// The identifier of the KMS symmetric customer managed key that was used for
    /// the object.
    ssekms_key_id: ?[]const u8 = null,

    /// The version of the object.
    version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .content_type = "ContentType",
        .e_tag = "ETag",
        .last_modified = "LastModified",
        .server_side_encryption = "ServerSideEncryption",
        .ssekms_key_id = "SSEKMSKeyId",
        .version_id = "VersionId",
    };
};
