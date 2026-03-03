/// Details of the parts that were uploaded.
pub const CompletedPart = struct {
    /// The Base64 encoded, 32-bit `CRC32` checksum of the part. This checksum is
    /// present if the
    /// multipart upload request was created with the `CRC32` checksum algorithm.
    /// For more
    /// information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_crc32: ?[]const u8 = null,

    /// The Base64 encoded, 32-bit `CRC32C` checksum of the part. This checksum is
    /// present if the
    /// multipart upload request was created with the `CRC32C` checksum algorithm.
    /// For more
    /// information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_crc32_c: ?[]const u8 = null,

    /// The Base64 encoded, 64-bit `CRC64NVME` checksum of the part. This checksum
    /// is present if
    /// the multipart upload request was created with the `CRC64NVME` checksum
    /// algorithm to the
    /// uploaded object). For more information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_crc64_nvme: ?[]const u8 = null,

    /// The Base64 encoded, 160-bit `SHA1` checksum of the part. This checksum is
    /// present if the
    /// multipart upload request was created with the `SHA1` checksum algorithm. For
    /// more
    /// information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_sha1: ?[]const u8 = null,

    /// The Base64 encoded, 256-bit `SHA256` checksum of the part. This checksum is
    /// present if
    /// the multipart upload request was created with the `SHA256` checksum
    /// algorithm. For more
    /// information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_sha256: ?[]const u8 = null,

    /// Entity tag returned when the part was uploaded.
    e_tag: ?[]const u8 = null,

    /// Part number that identifies the part. This is a positive integer between 1
    /// and 10,000.
    ///
    /// * **General purpose buckets** - In
    /// `CompleteMultipartUpload`, when a additional checksum (including
    /// `x-amz-checksum-crc32`, `x-amz-checksum-crc32c`,
    /// `x-amz-checksum-sha1`, or `x-amz-checksum-sha256`) is applied to each
    /// part, the `PartNumber` must start at 1 and the part numbers must be
    /// consecutive.
    /// Otherwise, Amazon S3 generates an HTTP `400 Bad Request` status code and an
    /// `InvalidPartOrder` error code.
    ///
    /// * **Directory buckets** - In
    /// `CompleteMultipartUpload`, the `PartNumber` must start at 1 and the part
    /// numbers must be consecutive.
    part_number: ?i32 = null,
};
