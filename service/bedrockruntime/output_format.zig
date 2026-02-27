const OutputFormatStructure = @import("output_format_structure.zig").OutputFormatStructure;
const OutputFormatType = @import("output_format_type.zig").OutputFormatType;

/// Structured output parameters to control the model's response.
pub const OutputFormat = struct {
    /// The structure that the model's output must adhere to.
    structure: OutputFormatStructure,

    /// The type of structured output format.
    type: OutputFormatType,

    pub const json_field_names = .{
        .structure = "structure",
        .type = "type",
    };
};
