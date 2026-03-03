const DiskImageFormat = @import("disk_image_format.zig").DiskImageFormat;

/// Describes a disk image.
pub const DiskImageDescription = struct {
    /// The checksum computed for the disk image.
    checksum: ?[]const u8 = null,

    /// The disk image format.
    format: ?DiskImageFormat = null,

    /// A presigned URL for the import manifest stored in Amazon S3. For information
    /// about creating a presigned URL for
    /// an Amazon S3 object, read the "Query String Request Authentication
    /// Alternative" section of the [Authenticating REST
    /// Requests](https://docs.aws.amazon.com/AmazonS3/latest/dev/RESTAuthentication.html) topic in
    /// the *Amazon Simple Storage Service Developer Guide*.
    ///
    /// For information about the import manifest referenced by this API action, see
    /// [VM Import
    /// Manifest](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/manifest.html).
    import_manifest_url: ?[]const u8 = null,

    /// The size of the disk image, in GiB.
    size: ?i64 = null,
};
