const SlotDefaultValue = @import("slot_default_value.zig").SlotDefaultValue;

/// Defines a list of values that Amazon Lex should use as the default value
/// for a slot.
pub const SlotDefaultValueSpecification = struct {
    /// A list of default values. Amazon Lex chooses the default value to use in
    /// the order that they are presented in the list.
    default_value_list: []const SlotDefaultValue,

    pub const json_field_names = .{
        .default_value_list = "defaultValueList",
    };
};
