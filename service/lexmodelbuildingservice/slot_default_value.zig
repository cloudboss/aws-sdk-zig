/// A default value for a slot.
pub const SlotDefaultValue = struct {
    /// The default value for the slot. You can specify one of the
    /// following:
    ///
    /// * `#context-name.slot-name` - The slot value "slot-name"
    /// in the context "context-name."
    ///
    /// * `{attribute}` - The slot value of the session attribute
    /// "attribute."
    ///
    /// * `'value'` - The discrete value "value."
    default_value: []const u8,

    pub const json_field_names = .{
        .default_value = "defaultValue",
    };
};
