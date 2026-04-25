const UpdatedDescriptorsUnion = @import("updated_descriptors_union.zig").UpdatedDescriptorsUnion;

/// Wrapper for updating an optional descriptors field with PATCH semantics.
/// When present with a value, individual descriptors can be updated. When
/// present with a null value, all descriptors are unset. When absent,
/// descriptors are left unchanged.
pub const UpdatedDescriptors = struct {
    /// The updated descriptors value. Contains per-descriptor-type wrappers that
    /// are each independently updatable.
    optional_value: ?UpdatedDescriptorsUnion = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
