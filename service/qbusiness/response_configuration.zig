const InstructionCollection = @import("instruction_collection.zig").InstructionCollection;

/// Configuration settings to define how Amazon Q Business generates and formats
/// responses to user queries. This includes customization options for response
/// style, tone, length, and other characteristics.
pub const ResponseConfiguration = struct {
    /// A collection of instructions that guide how Amazon Q Business generates
    /// responses, including parameters for response length, target audience,
    /// perspective, output style, identity, tone, and custom instructions.
    instruction_collection: ?InstructionCollection,

    pub const json_field_names = .{
        .instruction_collection = "instructionCollection",
    };
};
