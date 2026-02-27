const StructuredMessage = @import("structured_message.zig").StructuredMessage;

/// Represents a `StructureMessageName` to `DataType` map
/// element.
pub const StructuredMessageFieldNameAndDataTypePair = struct {
    /// The data type.
    data_type: StructuredMessage,

    /// The field name of the structured message. It determines how a data value is
    /// referenced
    /// in the target language.
    field_name: []const u8,

    pub const json_field_names = .{
        .data_type = "dataType",
        .field_name = "fieldName",
    };
};
