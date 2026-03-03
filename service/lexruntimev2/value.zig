/// Information about the value provided for a slot and Amazon Lex V2's
/// interpretation.
pub const Value = struct {
    /// The value that Amazon Lex V2 determines for the slot, given the user input.
    /// The actual value depends on the setting of the value selection strategy for
    /// the bot. You can choose to use the value entered by the user, or you can
    /// have Amazon Lex V2 choose the first value in the `resolvedValues` list.
    interpreted_value: []const u8,

    /// The part of the user's response to the slot elicitation that Amazon Lex V2
    /// determines is relevant to the slot value.
    original_value: ?[]const u8 = null,

    /// A list of values that Amazon Lex V2 determines are possible resolutions for
    /// the user input. The first value matches the `interpretedValue`.
    resolved_values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .interpreted_value = "interpretedValue",
        .original_value = "originalValue",
        .resolved_values = "resolvedValues",
    };
};
