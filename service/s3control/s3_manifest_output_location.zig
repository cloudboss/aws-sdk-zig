const GeneratedManifestEncryption = @import("generated_manifest_encryption.zig").GeneratedManifestEncryption;
const GeneratedManifestFormat = @import("generated_manifest_format.zig").GeneratedManifestFormat;

/// Location details for where the generated manifest should be written.
pub const S3ManifestOutputLocation = struct {
    /// The bucket ARN the generated manifest should be written to.
    ///
    /// **Directory buckets** - Directory buckets aren't supported
    /// as the buckets to store the generated manifest.
    bucket: []const u8,

    /// The Account ID that owns the bucket the generated manifest is written to.
    expected_manifest_bucket_owner: ?[]const u8,

    /// Specifies what encryption should be used when the generated manifest objects
    /// are
    /// written.
    manifest_encryption: ?GeneratedManifestEncryption,

    /// The format of the generated manifest.
    manifest_format: GeneratedManifestFormat,

    /// Prefix identifying one or more objects to which the manifest applies.
    manifest_prefix: ?[]const u8,
};
