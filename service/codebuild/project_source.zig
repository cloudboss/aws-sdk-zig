const SourceAuth = @import("source_auth.zig").SourceAuth;
const BuildStatusConfig = @import("build_status_config.zig").BuildStatusConfig;
const GitSubmodulesConfig = @import("git_submodules_config.zig").GitSubmodulesConfig;
const SourceType = @import("source_type.zig").SourceType;

/// Information about the build input source code for the build project.
pub const ProjectSource = struct {
    /// Information about the authorization settings for CodeBuild to access the
    /// source code to be
    /// built.
    auth: ?SourceAuth,

    /// The buildspec file declaration to use for the builds in this build project.
    ///
    /// If this value is set, it can be either an inline buildspec definition, the
    /// path to an
    /// alternate buildspec file relative to the value of the built-in
    /// `CODEBUILD_SRC_DIR` environment variable, or the path to an S3 bucket.
    /// The bucket must be in the same Amazon Web Services Region as the build
    /// project. Specify the buildspec
    /// file using its ARN (for example,
    /// `arn:aws:s3:::my-codebuild-sample2/buildspec.yml`). If this value is not
    /// provided or is set to an empty string, the source code must contain a
    /// buildspec file in
    /// its root directory. For more information, see [Buildspec File Name and
    /// Storage
    /// Location](https://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html#build-spec-ref-name-storage).
    buildspec: ?[]const u8,

    /// Contains information that defines how the build project reports the build
    /// status to
    /// the source provider. This option is only used when the source provider is
    /// `GITHUB`, `GITHUB_ENTERPRISE`, or
    /// `BITBUCKET`.
    build_status_config: ?BuildStatusConfig,

    /// Information about the Git clone depth for the build project.
    git_clone_depth: ?i32,

    /// Information about the Git submodules configuration for the build project.
    git_submodules_config: ?GitSubmodulesConfig,

    /// Enable this flag to ignore SSL warnings while connecting to the project
    /// source
    /// code.
    insecure_ssl: ?bool,

    /// Information about the location of the source code to be built. Valid values
    /// include:
    ///
    /// * For source code settings that are specified in the source action of a
    ///   pipeline
    /// in CodePipeline, `location` should not be specified. If it is specified,
    /// CodePipeline ignores it. This is because CodePipeline uses the settings in a
    /// pipeline's source
    /// action instead of this value.
    ///
    /// * For source code in an CodeCommit repository, the HTTPS clone URL to the
    ///   repository
    /// that contains the source code and the buildspec file (for example,
    /// `https://git-codecommit..amazonaws.com/v1/repos/`).
    ///
    /// * For source code in an Amazon S3 input bucket, one of the following.
    ///
    /// * The path to the ZIP file that contains the source code (for example,
    /// `//.zip`).
    ///
    /// * The path to the folder that contains the source code (for example,
    /// `///`).
    ///
    /// * For source code in a GitHub repository, the HTTPS clone URL to the
    ///   repository
    /// that contains the source and the buildspec file. You must connect your
    /// Amazon Web Services account
    /// to your GitHub account. Use the CodeBuild console to start creating a build
    /// project. When you use the console to connect (or reconnect) with GitHub, on
    /// the
    /// GitHub **Authorize application** page, for
    /// **Organization access**, choose **Request access** next to each repository
    /// you want to
    /// allow CodeBuild to have access to, and then choose **Authorize
    /// application**. (After you have connected to your GitHub account,
    /// you do not need to finish creating the build project. You can leave the
    /// CodeBuild
    /// console.) To instruct CodeBuild to use this connection, in the `source`
    /// object, set the `auth` object's `type` value to
    /// `OAUTH`.
    ///
    /// * For source code in an GitLab or self-managed GitLab repository, the HTTPS
    ///   clone URL to the repository
    /// that contains the source and the buildspec file. You must connect your
    /// Amazon Web Services account
    /// to your GitLab account. Use the CodeBuild console to start creating a build
    /// project. When you use the console to connect (or reconnect) with GitLab, on
    /// the
    /// Connections **Authorize application** page, choose **Authorize**. Then on
    /// the CodeConnections **Create GitLab connection** page,
    /// choose **Connect to GitLab**. (After you have connected to your GitLab
    /// account,
    /// you do not need to finish creating the build project. You can leave the
    /// CodeBuild
    /// console.) To instruct CodeBuild to override the default connection and use
    /// this connection instead,
    /// set the `auth` object's `type` value to
    /// `CODECONNECTIONS` in the `source` object.
    ///
    /// * For source code in a Bitbucket repository, the HTTPS clone URL to the
    /// repository that contains the source and the buildspec file. You must connect
    /// your Amazon Web Services account to your Bitbucket account. Use the
    /// CodeBuild console to start
    /// creating a build project. When you use the console to connect (or reconnect)
    /// with Bitbucket, on the Bitbucket **Confirm access to your
    /// account** page, choose **Grant
    /// access**. (After you have connected to your Bitbucket account, you
    /// do not need to finish creating the build project. You can leave the
    /// CodeBuild
    /// console.) To instruct CodeBuild to use this connection, in the `source`
    /// object, set the `auth` object's `type` value to
    /// `OAUTH`.
    ///
    /// If you specify `CODEPIPELINE` for the `Type` property, don't specify this
    /// property. For all of the other types, you must specify `Location`.
    location: ?[]const u8,

    /// Set to true to report the status of a build's start and finish to your
    /// source
    /// provider. This option is valid only when your source provider is GitHub,
    /// GitHub
    /// Enterprise, GitLab, GitLab Self Managed, GitLab, GitLab Self Managed, or
    /// Bitbucket. If this is set and you use a different source provider, an
    /// `invalidInputException` is thrown.
    ///
    /// To be able to report the build status to the source provider, the user
    /// associated with the source provider must
    /// have write access to the repo. If the user does not have write access, the
    /// build status cannot be updated. For more information, see [Source provider
    /// access](https://docs.aws.amazon.com/codebuild/latest/userguide/access-tokens.html) in the *CodeBuild User Guide*.
    ///
    /// The status of a build triggered by a webhook is always reported to your
    /// source
    /// provider.
    ///
    /// If your project's builds are triggered by a webhook, you must push a
    /// new commit to the repo for a change to this property to take
    /// effect.
    report_build_status: ?bool,

    /// An identifier for this project source. The identifier can only contain
    /// alphanumeric characters and underscores, and must be less than 128
    /// characters in length.
    source_identifier: ?[]const u8,

    /// The type of repository that contains the source code to be built. Valid
    /// values
    /// include:
    ///
    /// * `BITBUCKET`: The source code is in a Bitbucket repository.
    ///
    /// * `CODECOMMIT`: The source code is in an CodeCommit repository.
    ///
    /// * `CODEPIPELINE`: The source code settings are specified in the
    /// source action of a pipeline in CodePipeline.
    ///
    /// * `GITHUB`: The source code is in a GitHub repository.
    ///
    /// * `GITHUB_ENTERPRISE`: The source code is in a GitHub Enterprise
    /// Server repository.
    ///
    /// * `GITLAB`: The source code is in a GitLab repository.
    ///
    /// * `GITLAB_SELF_MANAGED`: The source code is in a self-managed GitLab
    ///   repository.
    ///
    /// * `NO_SOURCE`: The project does not have input source code.
    ///
    /// * `S3`: The source code is in an Amazon S3 bucket.
    @"type": SourceType,

    pub const json_field_names = .{
        .auth = "auth",
        .buildspec = "buildspec",
        .build_status_config = "buildStatusConfig",
        .git_clone_depth = "gitCloneDepth",
        .git_submodules_config = "gitSubmodulesConfig",
        .insecure_ssl = "insecureSsl",
        .location = "location",
        .report_build_status = "reportBuildStatus",
        .source_identifier = "sourceIdentifier",
        .@"type" = "type",
    };
};
