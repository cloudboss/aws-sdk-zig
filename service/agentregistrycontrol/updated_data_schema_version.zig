/// Leaf patch wrapper for a descriptor's data schema version. Omit to leave
/// unchanged; supply an empty object to unset; supply optionalValue to set.
pub const UpdatedDataSchemaVersion = struct {
    /// The value to set for this field. Omit the wrapper to leave the field
    /// unchanged.
    optional_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
