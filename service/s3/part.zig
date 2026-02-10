/// Container for elements related to a part.
pub const Part = struct {
    /// The Base64 encoded, 32-bit `CRC32` checksum of the part. This checksum is
    /// present if the
    /// object was uploaded with the `CRC32` checksum algorithm. For more
    /// information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the *Amazon S3 User Guide*.
    checksum_crc32: ?[]const u8,

    /// The Base64 encoded, 32-bit `CRC32C` checksum of the part. This checksum is
    /// present if the
    /// object was uploaded with the `CRC32C` checksum algorithm. For more
    /// information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the *Amazon S3 User Guide*.
    checksum_crc32_c: ?[]const u8,

    /// The Base64 encoded, 64-bit `CRC64NVME` checksum of the part. This checksum
    /// is present if
    /// the multipart upload request was created with the `CRC64NVME` checksum
    /// algorithm, or if the
    /// object was uploaded without a checksum (and Amazon S3 added the default
    /// checksum, `CRC64NVME`, to
    /// the uploaded object). For more information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_crc64_nvme: ?[]const u8,

    /// The Base64 encoded, 160-bit `SHA1` checksum of the part. This checksum is
    /// present if the
    /// object was uploaded with the `SHA1` checksum algorithm. For more
    /// information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the *Amazon S3 User Guide*.
    checksum_sha1: ?[]const u8,

    /// The Base64 encoded, 256-bit `SHA256` checksum of the part. This checksum is
    /// present if
    /// the object was uploaded with the `SHA256` checksum algorithm. For more
    /// information, see
    /// [Checking
    /// object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the *Amazon S3 User Guide*.
    checksum_sha256: ?[]const u8,

    /// Entity tag returned when the part was uploaded.
    e_tag: ?[]const u8,

    /// Date and time at which the part was uploaded.
    last_modified: ?i64,

    /// Part number identifying the part. This is a positive integer between 1 and
    /// 10,000.
    part_number: ?i32,

    /// Size in bytes of the uploaded part data.
    size: ?i64,
};
