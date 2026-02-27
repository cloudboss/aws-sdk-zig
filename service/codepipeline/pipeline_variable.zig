/// A pipeline-level variable used for a pipeline execution.
pub const PipelineVariable = struct {
    /// The name of a pipeline-level variable.
    name: []const u8,

    /// The value of a pipeline-level variable.
    value: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
