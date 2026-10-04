const ClientSideBeaconingConfiguration = @import("client_side_beaconing_configuration.zig").ClientSideBeaconingConfiguration;

/// The beaconing configuration for a playback configuration. Beaconing controls
/// whether MediaTailor includes its own beacons in the ad tracking response, in
/// addition to the ad server beacons.
pub const BeaconingConfiguration = struct {
    /// The beaconing settings for client-side reporting sessions. If you omit this
    /// object, MediaTailor uses `INSIGHTS` reporting mode.
    client_side: ?ClientSideBeaconingConfiguration = null,

    pub const json_field_names = .{
        .client_side = "ClientSide",
    };
};
