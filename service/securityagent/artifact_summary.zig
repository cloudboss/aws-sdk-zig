const ArtifactType = @import("artifact_type.zig").ArtifactType;

/// Contains summary information about an artifact.
pub const ArtifactSummary = struct {
    /// The unique identifier of the artifact.
    artifact_id: []const u8,

    /// The file type of the artifact.
    artifact_type: ArtifactType,

    /// The file name of the artifact.
    file_name: []const u8,

    pub const json_field_names = .{
        .artifact_id = "artifactId",
        .artifact_type = "artifactType",
        .file_name = "fileName",
    };
};
