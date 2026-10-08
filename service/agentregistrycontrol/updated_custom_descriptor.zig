const UpdatedCustomDescriptorFields = @import("updated_custom_descriptor_fields.zig").UpdatedCustomDescriptorFields;

/// The custom descriptor patch wrapper. Omit to leave the descriptor unchanged;
/// supply an empty object to remove it; supply optionalValue to patch its
/// fields.
pub const UpdatedCustomDescriptor = struct {
    /// The value to set for this field. Omit the wrapper to leave the field
    /// unchanged.
    optional_value: ?UpdatedCustomDescriptorFields = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
