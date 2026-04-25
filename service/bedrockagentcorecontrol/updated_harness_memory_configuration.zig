const HarnessMemoryConfiguration = @import("harness_memory_configuration.zig").HarnessMemoryConfiguration;

/// Wrapper for updating the memory configuration.
pub const UpdatedHarnessMemoryConfiguration = struct {
    /// The updated memory configuration value, or null to clear the existing
    /// configuration.
    optional_value: ?HarnessMemoryConfiguration = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
