/// Information about the build artifacts for the CodeBuild project.
pub const AwsCodeBuildProjectArtifactsDetails = struct {
    /// An identifier for the artifact definition.
    artifact_identifier: ?[]const u8 = null,

    /// Indicates whether to disable encryption on the artifact. Only valid when
    /// `Type` is `S3`.
    encryption_disabled: ?bool = null,

    /// Only used when `Type` is `S3`. The name of the S3 bucket where the artifact
    /// is located.
    location: ?[]const u8 = null,

    /// Only used when Type is S3. The name of the artifact. Used with
    /// `NamepaceType` and `Path` to determine the pattern for storing the artifact.
    name: ?[]const u8 = null,

    /// Only used when `Type` is `S3`. The value to use for the namespace. Used with
    /// `Name` and `Path` to determine the pattern for storing the artifact.
    namespace_type: ?[]const u8 = null,

    /// Whether the name specified in the buildspec file overrides the artifact
    /// name.
    override_artifact_name: ?bool = null,

    /// Only used when `Type` is `S3`. The type of output artifact to create.
    packaging: ?[]const u8 = null,

    /// Only used when `Type` is `S3`. The path to the artifact. Used with `Name`
    /// and `NamespaceType` to determine the pattern for storing the artifact.
    path: ?[]const u8 = null,

    /// The type of build artifact.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .artifact_identifier = "ArtifactIdentifier",
        .encryption_disabled = "EncryptionDisabled",
        .location = "Location",
        .name = "Name",
        .namespace_type = "NamespaceType",
        .override_artifact_name = "OverrideArtifactName",
        .packaging = "Packaging",
        .path = "Path",
        .@"type" = "Type",
    };
};
