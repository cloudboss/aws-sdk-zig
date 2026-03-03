const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;
const ChecksumType = @import("checksum_type.zig").ChecksumType;
const Owner = @import("owner.zig").Owner;
const RestoreStatus = @import("restore_status.zig").RestoreStatus;
const ObjectStorageClass = @import("object_storage_class.zig").ObjectStorageClass;

/// An object consists of data and its descriptive metadata.
pub const Object = struct {
    /// The algorithm that was used to create a checksum of the object.
    checksum_algorithm: ?[]const ChecksumAlgorithm = null,

    /// The checksum type that is used to calculate the object’s checksum value. For
    /// more information, see
    /// [Checking
    /// object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the *Amazon S3 User Guide*.
    checksum_type: ?ChecksumType = null,

    /// The entity tag is a hash of the object. The ETag reflects changes only to
    /// the contents of an object,
    /// not its metadata. The ETag may or may not be an MD5 digest of the object
    /// data. Whether or not it is
    /// depends on how the object was created and how it is encrypted as described
    /// below:
    ///
    /// * Objects created by the PUT Object, POST Object, or Copy operation, or
    ///   through the Amazon Web Services
    /// Management Console, and are encrypted by SSE-S3 or plaintext, have ETags
    /// that are an MD5 digest of
    /// their object data.
    ///
    /// * Objects created by the PUT Object, POST Object, or Copy operation, or
    ///   through the Amazon Web Services
    /// Management Console, and are encrypted by SSE-C or SSE-KMS, have ETags that
    /// are not an MD5 digest of
    /// their object data.
    ///
    /// * If an object is created by either the Multipart Upload or Part Copy
    ///   operation, the ETag is not
    /// an MD5 digest, regardless of the method of encryption. If an object is
    /// larger than 16 MB, the Amazon Web Services
    /// Management Console will upload or copy that object as a Multipart Upload,
    /// and therefore the ETag
    /// will not be an MD5 digest.
    ///
    /// **Directory buckets** - MD5 is not supported by directory buckets.
    e_tag: ?[]const u8 = null,

    /// The name that you assign to an object. You use the object key to retrieve
    /// the object.
    key: ?[]const u8 = null,

    /// Creation date of the object.
    last_modified: ?i64 = null,

    /// The owner of the object
    ///
    /// **Directory buckets** - The bucket owner is returned as the
    /// object owner.
    owner: ?Owner = null,

    /// Specifies the restoration status of an object. Objects in certain storage
    /// classes must be restored
    /// before they can be retrieved. For more information about these storage
    /// classes and how to work with
    /// archived objects, see [
    /// Working with archived
    /// objects](https://docs.aws.amazon.com/AmazonS3/latest/userguide/archived-objects.html) in the *Amazon S3 User Guide*.
    ///
    /// This functionality is not supported for directory buckets. Directory buckets
    /// only support `EXPRESS_ONEZONE` (the S3 Express One Zone storage class) in
    /// Availability Zones and `ONEZONE_IA` (the S3 One Zone-Infrequent Access
    /// storage class) in Dedicated Local Zones.
    restore_status: ?RestoreStatus = null,

    /// Size in bytes of the object
    size: ?i64 = null,

    /// The class of storage used to store the object.
    ///
    /// **Directory buckets** -
    /// Directory buckets only support `EXPRESS_ONEZONE` (the S3 Express One Zone
    /// storage class) in Availability Zones and `ONEZONE_IA` (the S3 One
    /// Zone-Infrequent Access storage class) in Dedicated Local Zones.
    storage_class: ?ObjectStorageClass = null,
};
