const ArtifactType = @import("artifact_type.zig").ArtifactType;

/// Represents an artifact that provides context for security testing, such as
/// documentation, diagrams, or configuration files.
pub const Artifact = struct {
    /// The content of the artifact.
    contents: []const u8,

    /// The file type of the artifact.
    type: ArtifactType,

    pub const json_field_names = .{
        .contents = "contents",
        .type = "type",
    };
};
