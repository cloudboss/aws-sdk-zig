const ArtifactLocation = @import("artifact_location.zig").ArtifactLocation;

/// Artifacts are the files that are worked on by actions in the pipeline. See
/// the
/// action configuration for each action for details about artifact parameters.
/// For example,
/// the S3 source action artifact is a file name (or file path), and the files
/// are generally
/// provided as a ZIP file. Example artifact name: SampleApp_Windows.zip
pub const Artifact = struct {
    /// The location of an artifact.
    location: ?ArtifactLocation,

    /// The artifact's name.
    name: ?[]const u8,

    /// The artifact's revision ID. Depending on the type of object, this could be a
    /// commit
    /// ID (GitHub) or a revision ID (Amazon S3).
    revision: ?[]const u8,

    pub const json_field_names = .{
        .location = "location",
        .name = "name",
        .revision = "revision",
    };
};
