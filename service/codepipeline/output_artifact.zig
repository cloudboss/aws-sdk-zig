/// Represents information about the output of an action.
pub const OutputArtifact = struct {
    /// The files that you want to associate with the output artifact that will be
    /// exported
    /// from the compute action.
    files: ?[]const []const u8,

    /// The name of the output of an artifact, such as "My App".
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
    ///
    /// Output artifact names must be unique within a pipeline.
    name: []const u8,

    pub const json_field_names = .{
        .files = "files",
        .name = "name",
    };
};
