const AutoDetectionConfiguration = @import("auto_detection_configuration.zig").AutoDetectionConfiguration;

/// A wrapper for updating the auto-detection configuration of a registry with
/// PATCH semantics. Include this wrapper to replace the auto-detection
/// configuration with the specified value. Omit it to leave the auto-detection
/// configuration unchanged. To clear the configuration, include the wrapper
/// with a null `optionalValue`.
pub const UpdatedAutoDetectionConfiguration = struct {
    /// The value to set for this field. Omit the wrapper to leave the field
    /// unchanged.
    optional_value: ?AutoDetectionConfiguration = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
