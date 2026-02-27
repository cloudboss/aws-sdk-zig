/// Code artifacts are source code artifacts and build artifacts used in a
/// repository
/// analysis or a pull request review.
///
/// * Source code artifacts are source code files in a Git repository that are
/// compressed into a .zip file.
///
/// * Build artifacts are .jar or .class files that are compressed in a .zip
/// file.
pub const CodeArtifacts = struct {
    /// The S3 object key for a build artifacts .zip file that contains .jar or
    /// .class files.
    /// This is required for a code review with security analysis. For more
    /// information, see [Create
    /// code reviews with GitHub
    /// Actions](https://docs.aws.amazon.com/codeguru/latest/reviewer-ug/working-with-cicd.html) in the *Amazon CodeGuru Reviewer User
    /// Guide*.
    build_artifacts_object_key: ?[]const u8,

    /// The S3 object key for a source code .zip file. This is required for all code
    /// reviews.
    source_code_artifacts_object_key: []const u8,

    pub const json_field_names = .{
        .build_artifacts_object_key = "BuildArtifactsObjectKey",
        .source_code_artifacts_object_key = "SourceCodeArtifactsObjectKey",
    };
};
