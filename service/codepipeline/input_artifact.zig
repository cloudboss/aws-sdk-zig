/// Represents information about an artifact to be worked on, such as a test or
/// build
/// artifact.
pub const InputArtifact = struct {
    /// The name of the artifact to be worked on (for example, "My App").
    ///
    /// Artifacts are the files that are worked on by actions in the pipeline. See
    /// the
    /// action configuration for each action for details about artifact parameters.
    /// For example,
    /// the S3 source action input artifact is a file name (or file path), and the
    /// files are
    /// generally provided as a ZIP file. Example artifact name:
    /// SampleApp_Windows.zip
    ///
    /// The input artifact of an action must exactly match the output artifact
    /// declared in
    /// a preceding action, but the input artifact does not have to be the next
    /// action in strict
    /// sequence from the action that provided the output artifact. Actions in
    /// parallel can
    /// declare different output artifacts, which are in turn consumed by different
    /// following
    /// actions.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
