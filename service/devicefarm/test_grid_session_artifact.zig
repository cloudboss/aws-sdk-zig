const TestGridSessionArtifactType = @import("test_grid_session_artifact_type.zig").TestGridSessionArtifactType;

/// Artifacts are video and other files that are produced in the process of
/// running a browser in an automated
/// context.
///
/// Video elements might be broken up into multiple artifacts as they grow in
/// size during creation.
pub const TestGridSessionArtifact = struct {
    /// The file name of the artifact.
    filename: ?[]const u8,

    /// The kind of artifact.
    type: ?TestGridSessionArtifactType,

    /// A semi-stable URL to the content of the object.
    url: ?[]const u8,

    pub const json_field_names = .{
        .filename = "filename",
        .type = "type",
        .url = "url",
    };
};
