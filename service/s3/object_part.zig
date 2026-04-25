/// A container for elements related to an individual part.
pub const ObjectPart = struct {
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
    /// algorithm, or if the
    /// object was uploaded without a checksum (and Amazon S3 added the default
    /// checksum, `CRC64NVME`, to
    /// the uploaded object). For more information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_crc64_nvme: ?[]const u8 = null,

    /// The Base64 encoded, 128-bit `MD5` digest of the part. This checksum is
    /// present if
    /// the multipart upload request was created with the `MD5` checksum algorithm.
    /// For more
    /// information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_md5: ?[]const u8 = null,

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

    /// The Base64 encoded, 512-bit `SHA512` digest of the part. This checksum is
    /// present if
    /// the multipart upload request was created with the `SHA512` checksum
    /// algorithm. For more
    /// information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_sha512: ?[]const u8 = null,

    /// The Base64 encoded, 128-bit `XXHASH128` checksum of the part. This checksum
    /// is present if
    /// the multipart upload request was created with the `XXHASH128` checksum
    /// algorithm. For more
    /// information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_xxhash128: ?[]const u8 = null,

    /// The Base64 encoded, 64-bit `XXHASH3` checksum of the part. This checksum is
    /// present if
    /// the multipart upload request was created with the `XXHASH3` checksum
    /// algorithm. For more
    /// information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_xxhash3: ?[]const u8 = null,

    /// The Base64 encoded, 64-bit `XXHASH64` checksum of the part. This checksum is
    /// present if
    /// the multipart upload request was created with the `XXHASH64` checksum
    /// algorithm. For more
    /// information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_xxhash64: ?[]const u8 = null,

    /// The part number identifying the part. This value is a positive integer
    /// between 1 and 10,000.
    part_number: ?i32 = null,

    /// The size of the uploaded part in bytes.
    size: ?i64 = null,
};
