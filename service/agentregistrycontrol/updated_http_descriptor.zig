const UpdatedHttpDescriptorFields = @import("updated_http_descriptor_fields.zig").UpdatedHttpDescriptorFields;

/// The HTTP descriptor patch wrapper. Omit to leave the descriptor unchanged;
/// supply an empty object to remove it; supply optionalValue to patch its
/// fields.
pub const UpdatedHttpDescriptor = struct {
    /// The value to set for this field. Omit the wrapper to leave the field
    /// unchanged.
    optional_value: ?UpdatedHttpDescriptorFields = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
