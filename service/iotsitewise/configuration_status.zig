const ConfigurationErrorDetails = @import("configuration_error_details.zig").ConfigurationErrorDetails;
const ConfigurationState = @import("configuration_state.zig").ConfigurationState;

/// Contains current status information for the configuration.
pub const ConfigurationStatus = struct {
    /// Contains associated error information, if any.
    @"error": ?ConfigurationErrorDetails = null,

    /// The current state of the configuration.
    state: ConfigurationState,

    pub const json_field_names = .{
        .@"error" = "error",
        .state = "state",
    };
};
