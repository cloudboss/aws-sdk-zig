const S3JobManifestGenerator = @import("s3_job_manifest_generator.zig").S3JobManifestGenerator;

/// Configures the type of the job's ManifestGenerator.
pub const JobManifestGenerator = union(enum) {
    /// The S3 job ManifestGenerator's configuration details.
    s3_job_manifest_generator: ?S3JobManifestGenerator,
};
