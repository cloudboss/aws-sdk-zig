/// Describes an artifact.
pub const Artifact = struct {
    /// The file name for the artifact.
    artifact_file_name: []const u8,

    /// The unique ID for the artifact.
    artifact_id: []const u8,

    pub const json_field_names = .{
        .artifact_file_name = "artifactFileName",
        .artifact_id = "artifactId",
    };
};
