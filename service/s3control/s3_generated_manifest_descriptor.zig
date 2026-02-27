const GeneratedManifestFormat = @import("generated_manifest_format.zig").GeneratedManifestFormat;
const JobManifestLocation = @import("job_manifest_location.zig").JobManifestLocation;

/// Describes the specified job's generated manifest. Batch Operations jobs
/// created with a
/// ManifestGenerator populate details of this descriptor after execution of the
/// ManifestGenerator.
pub const S3GeneratedManifestDescriptor = struct {
    /// The format of the generated manifest.
    format: ?GeneratedManifestFormat,

    location: ?JobManifestLocation,
};
