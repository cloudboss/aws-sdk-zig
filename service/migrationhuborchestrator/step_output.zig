const DataType = @import("data_type.zig").DataType;

/// The output of the step.
pub const StepOutput = struct {
    /// The data type of the step output.
    data_type: ?DataType = null,

    /// The name of the step.
    name: ?[]const u8 = null,

    /// Determine if an output is required from a step.
    required: ?bool = null,

    pub const json_field_names = .{
        .data_type = "dataType",
        .name = "name",
        .required = "required",
    };
};
