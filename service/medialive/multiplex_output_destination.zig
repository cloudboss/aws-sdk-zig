const MultiplexMediaConnectOutputDestinationSettings = @import("multiplex_media_connect_output_destination_settings.zig").MultiplexMediaConnectOutputDestinationSettings;

/// Multiplex output destination settings
pub const MultiplexOutputDestination = struct {
    /// Multiplex MediaConnect output destination settings.
    media_connect_settings: ?MultiplexMediaConnectOutputDestinationSettings,

    pub const json_field_names = .{
        .media_connect_settings = "MediaConnectSettings",
    };
};
