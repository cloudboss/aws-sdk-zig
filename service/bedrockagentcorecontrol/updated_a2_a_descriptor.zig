const A2aDescriptor = @import("a2_a_descriptor.zig").A2aDescriptor;

/// Wrapper for updating an A2A descriptor with PATCH semantics. When present,
/// the A2A descriptor is replaced with the provided value. When absent, the A2A
/// descriptor is left unchanged. To unset, include the wrapper with the value
/// set to null.
pub const UpdatedA2aDescriptor = struct {
    /// The updated A2A descriptor value.
    optional_value: ?A2aDescriptor = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
