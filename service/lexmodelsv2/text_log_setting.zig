const TextLogDestination = @import("text_log_destination.zig").TextLogDestination;

/// Defines settings to enable text conversation logs.
pub const TextLogSetting = struct {
    destination: TextLogDestination,

    /// Determines whether conversation logs should be stored for an
    /// alias.
    enabled: bool = false,

    /// The option to enable selective conversation log capture for text.
    selective_logging_enabled: ?bool,

    pub const json_field_names = .{
        .destination = "destination",
        .enabled = "enabled",
        .selective_logging_enabled = "selectiveLoggingEnabled",
    };
};
