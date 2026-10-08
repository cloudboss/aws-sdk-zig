const UpdatedAgUiDescriptorFields = @import("updated_ag_ui_descriptor_fields.zig").UpdatedAgUiDescriptorFields;

/// The AG-UI descriptor patch wrapper. Omit to leave the descriptor unchanged;
/// supply an empty object to remove it; supply optionalValue to patch its
/// fields.
pub const UpdatedAgUiDescriptor = struct {
    /// The value to set for this field. Omit the wrapper to leave the field
    /// unchanged.
    optional_value: ?UpdatedAgUiDescriptorFields = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
