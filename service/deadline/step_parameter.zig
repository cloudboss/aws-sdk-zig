const StepParameterChunks = @import("step_parameter_chunks.zig").StepParameterChunks;
const StepParameterType = @import("step_parameter_type.zig").StepParameterType;

/// The details of a step parameter.
pub const StepParameter = struct {
    /// The configuration for task chunking.
    chunks: ?StepParameterChunks = null,

    /// The name of the parameter.
    name: []const u8,

    /// The data type of the parameter.
    @"type": StepParameterType,

    pub const json_field_names = .{
        .chunks = "chunks",
        .name = "name",
        .@"type" = "type",
    };
};
