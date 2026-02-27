const StructuredMessageListType = @import("structured_message_list_type.zig").StructuredMessageListType;
const StructuredMessage = @import("structured_message.zig").StructuredMessage;

/// Represents a list type node of the complex data structure.
pub const StructuredMessageListDefinition = struct {
    /// The capacity of the structured message list definition when the list type is
    /// `FIXED_CAPACITY` or `DYNAMIC_BOUNDED_CAPACITY`.
    capacity: i32 = 0,

    /// The type of list of the structured message list definition.
    list_type: StructuredMessageListType,

    /// The member type of the structured message list definition.
    member_type: StructuredMessage,

    /// The name of the structured message list definition.
    name: []const u8,

    pub const json_field_names = .{
        .capacity = "capacity",
        .list_type = "listType",
        .member_type = "memberType",
        .name = "name",
    };
};
