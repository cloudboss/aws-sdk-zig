/// The value to set in a slot.
pub const SlotValue = struct {
    /// The value that Amazon Lex determines for the slot. The
    /// actual value depends on the setting of the value selection strategy for
    /// the bot. You can choose to use the value entered by the user, or you
    /// can have Amazon Lex choose the first value in the
    /// `resolvedValues` list.
    interpreted_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .interpreted_value = "interpretedValue",
    };
};
