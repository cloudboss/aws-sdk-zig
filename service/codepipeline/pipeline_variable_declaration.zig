/// A variable declared at the pipeline level.
pub const PipelineVariableDeclaration = struct {
    /// The value of a pipeline-level variable.
    default_value: ?[]const u8 = null,

    /// The description of a pipeline-level variable. It's used to add additional
    /// context
    /// about the variable, and not being used at time when pipeline executes.
    description: ?[]const u8 = null,

    /// The name of a pipeline-level variable.
    name: []const u8,

    pub const json_field_names = .{
        .default_value = "defaultValue",
        .description = "description",
        .name = "name",
    };
};
