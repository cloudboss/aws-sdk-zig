const ConfigurationError = @import("configuration_error.zig").ConfigurationError;
const ConfigurationState = @import("configuration_state.zig").ConfigurationState;

/// Provides the status of the default encryption configuration for an Amazon
/// Web Services account.
pub const ConfigurationStatus = struct {
    /// The error details describing a failed default encryption configuration
    /// update.
    @"error": ?ConfigurationError,

    /// The status state describing the default encryption configuration update.
    state: ConfigurationState,

    pub const json_field_names = .{
        .@"error" = "error",
        .state = "state",
    };
};
