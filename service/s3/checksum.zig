const ChecksumType = @import("checksum_type.zig").ChecksumType;

/// Contains all the possible checksum or digest values for an object.
pub const Checksum = struct {
    /// The Base64 encoded, 32-bit `CRC32 checksum` of the object. This checksum is
    /// only present if the checksum was uploaded
    /// with the object. When you use an API operation on an object that was
    /// uploaded using multipart uploads, this value may not be a direct checksum
    /// value of the full object. Instead, it's a calculation based on the checksum
    /// values of each individual part. For more information about how checksums are
    /// calculated
    /// with multipart uploads, see [
    /// Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html#large-object-checksums) in the *Amazon S3 User Guide*.
    checksum_crc32: ?[]const u8 = null,

    /// The Base64 encoded, 32-bit `CRC32C` checksum of the object. This checksum is
    /// only present if the checksum was uploaded
    /// with the object. When you use an API operation on an object that was
    /// uploaded using multipart uploads, this value may not be a direct checksum
    /// value of the full object. Instead, it's a calculation based on the checksum
    /// values of each individual part. For more information about how checksums are
    /// calculated
    /// with multipart uploads, see [
    /// Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html#large-object-checksums) in the *Amazon S3 User Guide*.
    checksum_crc32_c: ?[]const u8 = null,

    /// The Base64 encoded, 64-bit `CRC64NVME` checksum of the object. This checksum
    /// is present
    /// if the object was uploaded with the `CRC64NVME` checksum algorithm, or if
    /// the object was
    /// uploaded without a checksum (and Amazon S3 added the default checksum,
    /// `CRC64NVME`, to the
    /// uploaded object). For more information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_crc64_nvme: ?[]const u8 = null,

    /// The Base64 encoded, 128-bit `MD5` digest of the object. This checksum is
    /// present
    /// if the object was uploaded with the `MD5` checksum algorithm. For more
    /// information, see
    /// [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_md5: ?[]const u8 = null,

    /// The Base64 encoded, 160-bit `SHA1` digest of the object. This checksum is
    /// only present if the checksum was uploaded
    /// with the object. When you use the API operation on an object that was
    /// uploaded using multipart uploads, this value may not be a direct checksum
    /// value of the full object. Instead, it's a calculation based on the checksum
    /// values of each individual part. For more information about how checksums are
    /// calculated
    /// with multipart uploads, see [
    /// Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html#large-object-checksums) in the *Amazon S3 User Guide*.
    checksum_sha1: ?[]const u8 = null,

    /// The Base64 encoded, 256-bit `SHA256` digest of the object. This checksum is
    /// only present if the checksum was uploaded
    /// with the object. When you use an API operation on an object that was
    /// uploaded using multipart uploads, this value may not be a direct checksum
    /// value of the full object. Instead, it's a calculation based on the checksum
    /// values of each individual part. For more information about how checksums are
    /// calculated
    /// with multipart uploads, see [
    /// Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html#large-object-checksums) in the *Amazon S3 User Guide*.
    checksum_sha256: ?[]const u8 = null,

    /// The Base64 encoded, 512-bit `SHA512` digest of the object. This checksum is
    /// present
    /// if the object was uploaded with the `SHA512` checksum algorithm. For more
    /// information, see
    /// [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_sha512: ?[]const u8 = null,

    /// The checksum type that is used to calculate the object’s checksum value. For
    /// more information, see
    /// [Checking
    /// object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the *Amazon S3 User Guide*.
    checksum_type: ?ChecksumType = null,

    /// The Base64 encoded, 128-bit `XXHASH128` checksum of the object. This
    /// checksum is present
    /// if the object was uploaded with the `XXHASH128` checksum algorithm. For more
    /// information, see
    /// [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_xxhash128: ?[]const u8 = null,

    /// The Base64 encoded, 64-bit `XXHASH3` checksum of the object. This checksum
    /// is present
    /// if the object was uploaded with the `XXHASH3` checksum algorithm. For more
    /// information, see
    /// [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_xxhash3: ?[]const u8 = null,

    /// The Base64 encoded, 64-bit `XXHASH64` checksum of the object. This checksum
    /// is present
    /// if the object was uploaded with the `XXHASH64` checksum algorithm. For more
    /// information, see
    /// [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    checksum_xxhash64: ?[]const u8 = null,
};
