const CodeArtifacts = @import("code_artifacts.zig").CodeArtifacts;

/// Specifies the name of an S3 bucket and a `CodeArtifacts` object that
/// contains
/// the S3 object keys for a source code .zip file and for a build artifacts
/// .zip file that
/// contains .jar or .class files.
pub const S3RepositoryDetails = struct {
    /// The name of the S3 bucket used for associating a new S3 repository. It must
    /// begin with `codeguru-reviewer-`.
    bucket_name: ?[]const u8,

    /// A `CodeArtifacts` object. The `CodeArtifacts` object includes the
    /// S3 object key for a source code .zip file and for a build artifacts .zip
    /// file that contains
    /// .jar or .class files.
    code_artifacts: ?CodeArtifacts,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .code_artifacts = "CodeArtifacts",
    };
};
