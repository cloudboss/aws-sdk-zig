const SlotDefaultValue = @import("slot_default_value.zig").SlotDefaultValue;

/// Contains the default values for a slot. Default values are used when
/// Amazon Lex hasn't determined a value for a slot.
pub const SlotDefaultValueSpec = struct {
    /// The default values for a slot. You can specify more than one default.
    /// For example, you can specify a default value to use from a matching
    /// context variable, a session attribute, or a fixed value.
    ///
    /// The default value chosen is selected based on the order that you
    /// specify them in the list. For example, if you specify a context variable
    /// and a fixed value in that order, Amazon Lex uses the context variable if it
    /// is
    /// available, else it uses the fixed value.
    default_value_list: []const SlotDefaultValue,

    pub const json_field_names = .{
        .default_value_list = "defaultValueList",
    };
};
