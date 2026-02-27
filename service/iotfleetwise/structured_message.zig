const PrimitiveMessageDefinition = @import("primitive_message_definition.zig").PrimitiveMessageDefinition;
const StructuredMessageFieldNameAndDataTypePair = @import("structured_message_field_name_and_data_type_pair.zig").StructuredMessageFieldNameAndDataTypePair;
const StructuredMessageListDefinition = @import("structured_message_list_definition.zig").StructuredMessageListDefinition;

/// The structured message for the message signal. It can be defined with either
/// a
/// `primitiveMessageDefinition`,
/// `structuredMessageListDefinition`, or
/// `structuredMessageDefinition` recursively.
pub const StructuredMessage = union(enum) {
    /// Represents a primitive type node of the complex data structure.
    primitive_message_definition: ?PrimitiveMessageDefinition,
    /// Represents a struct type node of the complex data structure.
    structured_message_definition: ?[]const StructuredMessageFieldNameAndDataTypePair,
    /// Represents a list type node of the complex data structure.
    structured_message_list_definition: ?StructuredMessageListDefinition,

    pub const json_field_names = .{
        .primitive_message_definition = "primitiveMessageDefinition",
        .structured_message_definition = "structuredMessageDefinition",
        .structured_message_list_definition = "structuredMessageListDefinition",
    };
};
