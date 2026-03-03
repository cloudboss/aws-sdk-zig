/// A pipeline-level variable used for a pipeline execution.
pub const ResolvedPipelineVariable = struct {
    /// The name of a pipeline-level variable.
    name: ?[]const u8 = null,

    /// The resolved value of a pipeline-level variable.
    resolved_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .resolved_value = "resolvedValue",
    };
};
