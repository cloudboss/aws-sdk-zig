const S3RepositoryDetails = @import("s3_repository_details.zig").S3RepositoryDetails;

/// Information about an associated repository in an S3 bucket. The associated
/// repository
/// contains a source code .zip file and a build artifacts .zip file that
/// contains .jar or
/// .class files.
pub const S3BucketRepository = struct {
    /// An `S3RepositoryDetails` object that specifies the name of an S3 bucket and
    /// a `CodeArtifacts` object. The `CodeArtifacts` object includes the S3 object
    /// keys for a source code .zip file and for a build artifacts .zip file.
    details: ?S3RepositoryDetails,

    /// The name of the repository when the `ProviderType` is
    /// `S3Bucket`.
    name: []const u8,

    pub const json_field_names = .{
        .details = "Details",
        .name = "Name",
    };
};
