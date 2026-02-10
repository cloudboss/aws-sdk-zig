/// Container for all response elements.
pub const CopyPartResult = struct {
    /// This header can be used as a data integrity check to verify that the data
    /// received is the same data
    /// that was originally sent. This header specifies the Base64 encoded, 32-bit
    /// `CRC32` checksum
    /// of the part. For more information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_crc32: ?[]const u8,

    /// This header can be used as a data integrity check to verify that the data
    /// received is the same data
    /// that was originally sent. This header specifies the Base64 encoded, 32-bit
    /// `CRC32C` checksum
    /// of the part. For more information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_crc32_c: ?[]const u8,

    /// The Base64 encoded, 64-bit `CRC64NVME` checksum of the part. This checksum
    /// is present if
    /// the multipart upload request was created with the `CRC64NVME` checksum
    /// algorithm to the
    /// uploaded object). For more information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_crc64_nvme: ?[]const u8,

    /// This header can be used as a data integrity check to verify that the data
    /// received is the same data
    /// that was originally sent. This header specifies the Base64 encoded, 160-bit
    /// `SHA1` checksum
    /// of the part. For more information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_sha1: ?[]const u8,

    /// This header can be used as a data integrity check to verify that the data
    /// received is the same data
    /// that was originally sent. This header specifies the Base64 encoded, 256-bit
    /// `SHA256` checksum
    /// of the part. For more information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_sha256: ?[]const u8,

    /// Entity tag of the object.
    e_tag: ?[]const u8,

    /// Date and time at which the object was uploaded.
    last_modified: ?i64,
};
