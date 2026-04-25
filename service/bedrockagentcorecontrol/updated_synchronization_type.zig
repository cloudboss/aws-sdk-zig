const SynchronizationType = @import("synchronization_type.zig").SynchronizationType;

/// Wrapper for updating the synchronization type with PATCH semantics. Must be
/// matched with `UpdatedSynchronizationConfiguration`.
pub const UpdatedSynchronizationType = struct {
    /// The updated synchronization type value.
    optional_value: ?SynchronizationType = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
