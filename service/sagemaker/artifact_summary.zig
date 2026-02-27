const ArtifactSource = @import("artifact_source.zig").ArtifactSource;

/// Lists a summary of the properties of an artifact. An artifact represents a
/// URI addressable object or data. Some examples are a dataset and a model.
pub const ArtifactSummary = struct {
    /// The Amazon Resource Name (ARN) of the artifact.
    artifact_arn: ?[]const u8,

    /// The name of the artifact.
    artifact_name: ?[]const u8,

    /// The type of the artifact.
    artifact_type: ?[]const u8,

    /// When the artifact was created.
    creation_time: ?i64,

    /// When the artifact was last modified.
    last_modified_time: ?i64,

    /// The source of the artifact.
    source: ?ArtifactSource,

    pub const json_field_names = .{
        .artifact_arn = "ArtifactArn",
        .artifact_name = "ArtifactName",
        .artifact_type = "ArtifactType",
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
        .source = "Source",
    };
};
