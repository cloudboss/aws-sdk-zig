const JobManifestGeneratorFilter = @import("job_manifest_generator_filter.zig").JobManifestGeneratorFilter;
const S3ManifestOutputLocation = @import("s3_manifest_output_location.zig").S3ManifestOutputLocation;

/// The container for the service that will create the S3 manifest.
pub const S3JobManifestGenerator = struct {
    /// Determines whether or not to write the job's generated manifest to a bucket.
    enable_manifest_output: bool = false,

    /// The Amazon Web Services account ID that owns the bucket the generated
    /// manifest is written to. If
    /// provided the generated manifest bucket's owner Amazon Web Services account
    /// ID must match this value, else
    /// the job fails.
    expected_bucket_owner: ?[]const u8 = null,

    /// Specifies rules the S3JobManifestGenerator should use to decide whether an
    /// object
    /// in the source bucket should or should not be included in the generated job
    /// manifest.
    filter: ?JobManifestGeneratorFilter = null,

    /// Specifies the location the generated manifest will be written to. Manifests
    /// can't be
    /// written to directory buckets. For more information, see [Directory
    /// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-buckets-overview.html).
    manifest_output_location: ?S3ManifestOutputLocation = null,

    /// The ARN of the source bucket used by the ManifestGenerator.
    ///
    /// **Directory buckets** - Directory buckets aren't supported
    /// as the source buckets used by `S3JobManifestGenerator` to generate the job
    /// manifest.
    source_bucket: []const u8,
};
