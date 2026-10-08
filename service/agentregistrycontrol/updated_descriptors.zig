const UpdatedDescriptorsFields = @import("updated_descriptors_fields.zig").UpdatedDescriptorsFields;

/// The top-level descriptors patch wrapper used in UpdateRegistryRecord. Omit
/// to leave the current descriptors unchanged; supply an empty object to clear
/// them; supply optionalValue to apply a per-field patch.
pub const UpdatedDescriptors = struct {
    /// The value to set for this field. Omit the wrapper to leave the field
    /// unchanged.
    optional_value: ?UpdatedDescriptorsFields = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
