/// Information about the build input source code for this build project.
pub const AwsCodeBuildProjectSource = struct {
    /// Information about the Git clone depth for the build project.
    git_clone_depth: ?i32,

    /// Whether to ignore SSL warnings while connecting to the project source code.
    insecure_ssl: ?bool,

    /// Information about the location of the source code to be built.
    ///
    /// Valid values include:
    ///
    /// * For source code settings that are specified in the source action of a
    ///   pipeline in
    /// CodePipeline, location should not be specified. If it is specified,
    /// CodePipeline ignores it. This is because CodePipeline uses the settings in a
    /// pipeline's source action instead of this value.
    ///
    /// * For source code in an CodeCommit repository, the HTTPS clone URL to the
    /// repository that contains the source code and the build spec file (for
    /// example,
    /// `https://git-codecommit.region-ID.amazonaws.com/v1/repos/repo-name`
    /// ).
    ///
    /// * For source code in an S3 input bucket, one of the following.
    ///
    /// * The path to the ZIP file that contains the source code (for example,
    /// `bucket-name/path/to/object-name.zip`).
    ///
    /// * The path to the folder that contains the source code (for example,
    /// `bucket-name/path/to/source-code/folder/`).
    ///
    /// * For source code in a GitHub repository, the HTTPS clone URL to the
    ///   repository that
    /// contains the source and the build spec file.
    ///
    /// * For source code in a Bitbucket repository, the HTTPS clone URL to the
    ///   repository
    /// that contains the source and the build spec file.
    location: ?[]const u8,

    /// The type of repository that contains the source code to be built. Valid
    /// values
    /// are:
    ///
    /// * `BITBUCKET` - The source code is in a Bitbucket repository.
    ///
    /// * `CODECOMMIT` - The source code is in an CodeCommit
    /// repository.
    ///
    /// * `CODEPIPELINE` - The source code settings are specified in the source
    /// action of a pipeline in CodePipeline.
    ///
    /// * `GITHUB` - The source code is in a GitHub repository.
    ///
    /// * `GITHUB_ENTERPRISE` - The source code is in a GitHub Enterprise
    /// repository.
    ///
    /// * `NO_SOURCE` - The project does not have input source code.
    ///
    /// * `S3` - The source code is in an S3 input bucket.
    type: ?[]const u8,

    pub const json_field_names = .{
        .git_clone_depth = "GitCloneDepth",
        .insecure_ssl = "InsecureSsl",
        .location = "Location",
        .type = "Type",
    };
};
