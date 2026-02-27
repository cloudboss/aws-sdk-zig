const JobManifestLocation = @import("job_manifest_location.zig").JobManifestLocation;
const JobManifestSpec = @import("job_manifest_spec.zig").JobManifestSpec;

/// Contains the configuration information for a job's manifest.
pub const JobManifest = struct {
    /// Contains the information required to locate the specified job's manifest.
    /// Manifests
    /// can't be imported from directory buckets. For more information, see
    /// [Directory
    /// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-buckets-overview.html).
    location: JobManifestLocation,

    /// Describes the format of the specified job's manifest. If the manifest is in
    /// CSV format,
    /// also describes the columns contained within the manifest.
    spec: JobManifestSpec,
};
