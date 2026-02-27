const DataType = @import("data_type.zig").DataType;
const WorkflowStepOutputUnion = @import("workflow_step_output_union.zig").WorkflowStepOutputUnion;

/// The output of a step.
pub const WorkflowStepOutput = struct {
    /// The data type of the output.
    data_type: ?DataType,

    /// The name of the step.
    name: ?[]const u8,

    /// Determine if an output is required from a step.
    required: ?bool,

    /// The value of the output.
    value: ?WorkflowStepOutputUnion,

    pub const json_field_names = .{
        .data_type = "dataType",
        .name = "name",
        .required = "required",
        .value = "value",
    };
};
