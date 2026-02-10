const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;
const ChecksumType = @import("checksum_type.zig").ChecksumType;
const Initiator = @import("initiator.zig").Initiator;
const Owner = @import("owner.zig").Owner;
const StorageClass = @import("storage_class.zig").StorageClass;

/// Container for the `MultipartUpload` for the Amazon S3 object.
pub const MultipartUpload = struct {
    /// The algorithm that was used to create a checksum of the object.
    checksum_algorithm: ?ChecksumAlgorithm,

    /// The checksum type that is used to calculate the object’s checksum value. For
    /// more information, see
    /// [Checking
    /// object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the *Amazon S3 User Guide*.
    checksum_type: ?ChecksumType,

    /// Date and time at which the multipart upload was initiated.
    initiated: ?i64,

    /// Identifies who initiated the multipart upload.
    initiator: ?Initiator,

    /// Key of the object for which the multipart upload was initiated.
    key: ?[]const u8,

    /// Specifies the owner of the object that is part of the multipart upload.
    ///
    /// **Note:**
    ///
    /// **Directory buckets** - The bucket owner is returned as the
    /// object owner for all the objects.
    owner: ?Owner,

    /// The class of storage used to store the object.
    ///
    /// **Note:**
    ///
    /// **Directory buckets** -
    /// Directory buckets only support `EXPRESS_ONEZONE` (the S3 Express One Zone
    /// storage class) in Availability Zones and `ONEZONE_IA` (the S3 One
    /// Zone-Infrequent Access storage class) in Dedicated Local Zones.
    storage_class: ?StorageClass,

    /// Upload ID that identifies the multipart upload.
    upload_id: ?[]const u8,
};
