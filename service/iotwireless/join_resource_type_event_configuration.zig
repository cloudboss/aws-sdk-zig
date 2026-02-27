const LoRaWANJoinResourceTypeEventConfiguration = @import("lo_ra_wan_join_resource_type_event_configuration.zig").LoRaWANJoinResourceTypeEventConfiguration;

/// Join resource type event configuration object for enabling or disabling
/// topic.
pub const JoinResourceTypeEventConfiguration = struct {
    /// Join resource type event configuration object for enabling or disabling
    /// LoRaWAN
    /// related event topics.
    lo_ra_wan: ?LoRaWANJoinResourceTypeEventConfiguration,

    pub const json_field_names = .{
        .lo_ra_wan = "LoRaWAN",
    };
};
