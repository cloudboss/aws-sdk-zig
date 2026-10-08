/// Wrapper for updating an optional Description field with PATCH semantics
pub const UpdatedDescription = struct {
    /// The value to set for this field. Omit the wrapper to leave the field
    /// unchanged.
    optional_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
