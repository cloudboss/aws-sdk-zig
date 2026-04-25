const CustomDescriptor = @import("custom_descriptor.zig").CustomDescriptor;

/// Wrapper for updating a custom descriptor with PATCH semantics. When present,
/// the custom descriptor is replaced with the provided value. When absent, the
/// custom descriptor is left unchanged. To unset, include the wrapper with the
/// value set to null.
pub const UpdatedCustomDescriptor = struct {
    /// The updated custom descriptor value.
    optional_value: ?CustomDescriptor = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
