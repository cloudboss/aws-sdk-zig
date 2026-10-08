const DescriptorSource = @import("descriptor_source.zig").DescriptorSource;

/// Leaf patch wrapper for a descriptor's source configuration. Omit to leave
/// unchanged; supply an empty object to unset; supply optionalValue to set.
pub const UpdatedDescriptorSource = struct {
    /// The value to set for this field. Omit the wrapper to leave the field
    /// unchanged.
    optional_value: ?DescriptorSource = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
