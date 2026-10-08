/// Contains metadata about an artifact.
pub const ArtifactMetadataItem = struct {
    /// The unique identifier of the agent space that contains the artifact.
    agent_space_id: []const u8,

    /// The unique identifier of the artifact.
    artifact_id: []const u8,

    /// The file name of the artifact.
    file_name: []const u8,

    /// The date and time the artifact was last updated, in UTC format.
    updated_at: i64,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .artifact_id = "artifactId",
        .file_name = "fileName",
        .updated_at = "updatedAt",
    };
};
