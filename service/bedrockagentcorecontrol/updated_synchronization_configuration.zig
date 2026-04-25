const SynchronizationConfiguration = @import("synchronization_configuration.zig").SynchronizationConfiguration;

/// Wrapper for updating the synchronization configuration with PATCH semantics.
/// Must be matched with `UpdatedSynchronizationType`.
pub const UpdatedSynchronizationConfiguration = struct {
    /// The updated synchronization configuration value.
    optional_value: ?SynchronizationConfiguration = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
