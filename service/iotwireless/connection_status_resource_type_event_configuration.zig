const LoRaWANConnectionStatusResourceTypeEventConfiguration = @import("lo_ra_wan_connection_status_resource_type_event_configuration.zig").LoRaWANConnectionStatusResourceTypeEventConfiguration;

/// Connection status resource type event configuration object for enabling or
/// disabling
/// topic.
pub const ConnectionStatusResourceTypeEventConfiguration = struct {
    /// Connection status resource type event configuration object for enabling or
    /// disabling
    /// LoRaWAN related event topics.
    lo_ra_wan: ?LoRaWANConnectionStatusResourceTypeEventConfiguration,

    pub const json_field_names = .{
        .lo_ra_wan = "LoRaWAN",
    };
};
