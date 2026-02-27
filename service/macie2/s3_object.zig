const ServerSideEncryption = @import("server_side_encryption.zig").ServerSideEncryption;
const StorageClass = @import("storage_class.zig").StorageClass;
const KeyValuePair = @import("key_value_pair.zig").KeyValuePair;

/// Provides information about the S3 object that a finding applies to.
pub const S3Object = struct {
    /// The Amazon Resource Name (ARN) of the bucket that contains the object.
    bucket_arn: ?[]const u8,

    /// The entity tag (ETag) that identifies the affected version of the object. If
    /// the object was overwritten or changed after Amazon Macie produced the
    /// finding, this value might be different from the current ETag for the object.
    e_tag: ?[]const u8,

    /// The file name extension of the object. If the object doesn't have a file
    /// name extension, this value is "".
    extension: ?[]const u8,

    /// The full name (*key*) of the object, including the object's prefix if
    /// applicable.
    key: ?[]const u8,

    /// The date and time, in UTC and extended ISO 8601 format, when the object was
    /// last modified.
    last_modified: ?i64,

    /// The full path to the affected object, including the name of the affected
    /// bucket and the object's name (key).
    path: ?[]const u8,

    /// Specifies whether the object is publicly accessible due to the combination
    /// of permissions settings that apply to the object.
    public_access: ?bool,

    /// The type of server-side encryption that was used to encrypt the object.
    server_side_encryption: ?ServerSideEncryption,

    /// The total storage size, in bytes, of the object.
    size: ?i64,

    /// The storage class of the object.
    storage_class: ?StorageClass,

    /// The tags that are associated with the object.
    tags: ?[]const KeyValuePair,

    /// The identifier for the affected version of the object.
    version_id: ?[]const u8,

    pub const json_field_names = .{
        .bucket_arn = "bucketArn",
        .e_tag = "eTag",
        .extension = "extension",
        .key = "key",
        .last_modified = "lastModified",
        .path = "path",
        .public_access = "publicAccess",
        .server_side_encryption = "serverSideEncryption",
        .size = "size",
        .storage_class = "storageClass",
        .tags = "tags",
        .version_id = "versionId",
    };
};
