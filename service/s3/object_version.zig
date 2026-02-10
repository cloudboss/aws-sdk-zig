const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;
const ChecksumType = @import("checksum_type.zig").ChecksumType;
const Owner = @import("owner.zig").Owner;
const RestoreStatus = @import("restore_status.zig").RestoreStatus;
const ObjectVersionStorageClass = @import("object_version_storage_class.zig").ObjectVersionStorageClass;

/// The version of an object.
pub const ObjectVersion = struct {
    /// The algorithm that was used to create a checksum of the object.
    checksum_algorithm: ?[]const ChecksumAlgorithm,

    /// The checksum type that is used to calculate the object’s checksum value. For
    /// more information, see
    /// [Checking
    /// object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the *Amazon S3 User Guide*.
    checksum_type: ?ChecksumType,

    /// The entity tag is an MD5 hash of that version of the object.
    e_tag: ?[]const u8,

    /// Specifies whether the object is (true) or is not (false) the latest version
    /// of an object.
    is_latest: ?bool,

    /// The object key.
    key: ?[]const u8,

    /// Date and time when the object was last modified.
    last_modified: ?i64,

    /// Specifies the owner of the object.
    owner: ?Owner,

    /// Specifies the restoration status of an object. Objects in certain storage
    /// classes must be restored
    /// before they can be retrieved. For more information about these storage
    /// classes and how to work with
    /// archived objects, see [
    /// Working with archived
    /// objects](https://docs.aws.amazon.com/AmazonS3/latest/userguide/archived-objects.html) in the *Amazon S3 User Guide*.
    restore_status: ?RestoreStatus,

    /// Size in bytes of the object.
    size: ?i64,

    /// The class of storage used to store the object.
    storage_class: ?ObjectVersionStorageClass,

    /// Version ID of an object.
    version_id: ?[]const u8,
};
