const BucketOwnerAccess = @import("bucket_owner_access.zig").BucketOwnerAccess;
const ArtifactNamespace = @import("artifact_namespace.zig").ArtifactNamespace;
const ArtifactPackaging = @import("artifact_packaging.zig").ArtifactPackaging;
const ArtifactsType = @import("artifacts_type.zig").ArtifactsType;

/// Information about the build output artifacts for the build project.
pub const ProjectArtifacts = struct {
    /// An identifier for this artifact definition.
    artifact_identifier: ?[]const u8,

    bucket_owner_access: ?BucketOwnerAccess,

    /// Set to true if you do not want your output artifacts encrypted. This option
    /// is valid
    /// only if your artifacts type is Amazon S3. If this is set with another
    /// artifacts type, an
    /// invalidInputException is thrown.
    encryption_disabled: ?bool,

    /// Information about the build output artifact location:
    ///
    /// * If `type` is set to `CODEPIPELINE`, CodePipeline ignores this
    /// value if specified. This is because CodePipeline manages its build output
    /// locations
    /// instead of CodeBuild.
    ///
    /// * If `type` is set to `NO_ARTIFACTS`, this value is
    /// ignored if specified, because no build output is produced.
    ///
    /// * If `type` is set to `S3`, this is the name of the output
    /// bucket.
    location: ?[]const u8,

    /// Along with `path` and `namespaceType`, the pattern that CodeBuild
    /// uses to name and store the output artifact:
    ///
    /// * If `type` is set to `CODEPIPELINE`, CodePipeline ignores this
    /// value if specified. This is because CodePipeline manages its build output
    /// names instead
    /// of CodeBuild.
    ///
    /// * If `type` is set to `NO_ARTIFACTS`, this value is
    /// ignored if specified, because no build output is produced.
    ///
    /// * If `type` is set to `S3`, this is the name of the output
    /// artifact object. If you set the name to be a forward slash ("/"), the
    /// artifact
    /// is stored in the root of the output bucket.
    ///
    /// For example:
    ///
    /// * If `path` is set to `MyArtifacts`,
    /// `namespaceType` is set to `BUILD_ID`, and
    /// `name` is set to `MyArtifact.zip`, then the output
    /// artifact is stored in `MyArtifacts//MyArtifact.zip`.
    ///
    /// * If `path` is empty, `namespaceType` is set to
    /// `NONE`, and `name` is set to "`/`", the
    /// output artifact is stored in the root of the output bucket.
    ///
    /// * If `path` is set to `MyArtifacts`,
    /// `namespaceType` is set to `BUILD_ID`, and
    /// `name` is set to "`/`", the output artifact is stored
    /// in `MyArtifacts/`.
    name: ?[]const u8,

    /// Along with `path` and `name`, the pattern that CodeBuild uses to
    /// determine the name and location to store the output artifact:
    ///
    /// * If `type` is set to `CODEPIPELINE`, CodePipeline ignores this
    /// value if specified. This is because CodePipeline manages its build output
    /// names instead
    /// of CodeBuild.
    ///
    /// * If `type` is set to `NO_ARTIFACTS`, this value is
    /// ignored if specified, because no build output is produced.
    ///
    /// * If `type` is set to `S3`, valid values include:
    ///
    /// * `BUILD_ID`: Include the build ID in the location of the
    /// build output artifact.
    ///
    /// * `NONE`: Do not include the build ID. This is the default if
    /// `namespaceType` is not specified.
    ///
    /// For example, if `path` is set to `MyArtifacts`,
    /// `namespaceType` is set to `BUILD_ID`, and `name` is
    /// set to `MyArtifact.zip`, the output artifact is stored in
    /// `MyArtifacts//MyArtifact.zip`.
    namespace_type: ?ArtifactNamespace,

    /// If this flag is set, a name specified in the buildspec file overrides the
    /// artifact
    /// name. The name specified in a buildspec file is calculated at build time and
    /// uses the
    /// Shell Command Language. For example, you can append a date and time to your
    /// artifact
    /// name so that it is always unique.
    override_artifact_name: ?bool,

    /// The type of build output artifact to create:
    ///
    /// * If `type` is set to `CODEPIPELINE`, CodePipeline ignores this
    /// value if specified. This is because CodePipeline manages its build output
    /// artifacts
    /// instead of CodeBuild.
    ///
    /// * If `type` is set to `NO_ARTIFACTS`, this value is
    /// ignored if specified, because no build output is produced.
    ///
    /// * If `type` is set to `S3`, valid values include:
    ///
    /// * `NONE`: CodeBuild creates in the output bucket a folder that
    /// contains the build output. This is the default if `packaging`
    /// is not specified.
    ///
    /// * `ZIP`: CodeBuild creates in the output bucket a ZIP file that
    /// contains the build output.
    packaging: ?ArtifactPackaging,

    /// Along with `namespaceType` and `name`, the pattern that CodeBuild
    /// uses to name and store the output artifact:
    ///
    /// * If `type` is set to `CODEPIPELINE`, CodePipeline ignores this
    /// value if specified. This is because CodePipeline manages its build output
    /// names instead
    /// of CodeBuild.
    ///
    /// * If `type` is set to `NO_ARTIFACTS`, this value is
    /// ignored if specified, because no build output is produced.
    ///
    /// * If `type` is set to `S3`, this is the path to the output
    /// artifact. If `path` is not specified, `path` is not
    /// used.
    ///
    /// For example, if `path` is set to `MyArtifacts`,
    /// `namespaceType` is set to `NONE`, and `name` is set
    /// to `MyArtifact.zip`, the output artifact is stored in the output bucket at
    /// `MyArtifacts/MyArtifact.zip`.
    path: ?[]const u8,

    /// The type of build output artifact. Valid values include:
    ///
    /// * `CODEPIPELINE`: The build project has build output generated
    /// through CodePipeline.
    ///
    /// The `CODEPIPELINE` type is not supported for
    /// `secondaryArtifacts`.
    ///
    /// * `NO_ARTIFACTS`: The build project does not produce any build
    /// output.
    ///
    /// * `S3`: The build project stores build output in Amazon S3.
    type: ArtifactsType,

    pub const json_field_names = .{
        .artifact_identifier = "artifactIdentifier",
        .bucket_owner_access = "bucketOwnerAccess",
        .encryption_disabled = "encryptionDisabled",
        .location = "location",
        .name = "name",
        .namespace_type = "namespaceType",
        .override_artifact_name = "overrideArtifactName",
        .packaging = "packaging",
        .path = "path",
        .type = "type",
    };
};
