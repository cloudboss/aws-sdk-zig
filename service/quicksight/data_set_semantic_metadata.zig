const CustomInstruction = @import("custom_instruction.zig").CustomInstruction;
const DataSetSemanticDescription = @import("data_set_semantic_description.zig").DataSetSemanticDescription;

/// Semantic metadata for a dataset, including a description and custom
/// instructions.
pub const DataSetSemanticMetadata = struct {
    /// A list of custom instructions that guide how the dataset should be consumed.
    custom_instructions: ?[]const CustomInstruction = null,

    /// A description of the dataset.
    description: ?DataSetSemanticDescription = null,

    pub const json_field_names = .{
        .custom_instructions = "CustomInstructions",
        .description = "Description",
    };
};
