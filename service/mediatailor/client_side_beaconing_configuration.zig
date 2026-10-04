const BeaconEventType = @import("beacon_event_type.zig").BeaconEventType;
const ClientSideBeaconingMode = @import("client_side_beaconing_mode.zig").ClientSideBeaconingMode;

/// The beaconing settings that apply to client-side reporting sessions: whether
/// MediaTailor includes its beacons in the ad tracking response, and which
/// player operation events it reports on.
pub const ClientSideBeaconingConfiguration = struct {
    /// The player operation events to report on, in addition to the ad progress
    /// events that MediaTailor always reports on. The default is an empty list.
    /// This parameter is valid only when `ReportingMode` is `INSIGHTS`. MediaTailor
    /// rejects the request if you specify a value while `ReportingMode` is
    /// `DISABLED`, or if you specify duplicate values.
    additional_event_types: ?[]const BeaconEventType = null,

    /// Specifies whether MediaTailor includes its beacons in the ad tracking
    /// response. Valid values, which are case-sensitive:
    ///
    /// * `INSIGHTS` – MediaTailor includes its beacons in the ad tracking response.
    /// * `DISABLED` – MediaTailor doesn't include its beacons in the ad tracking
    ///   response.
    ///
    /// If you send a `ClientSide` object, this setting is required. If you omit
    /// `BeaconingConfiguration` or `ClientSide` entirely, MediaTailor uses
    /// `INSIGHTS`.
    ///
    /// `PutPlaybackConfiguration` replaces the whole playback configuration. To
    /// keep beaconing off, include `DISABLED` in every subsequent write.
    reporting_mode: ClientSideBeaconingMode,

    pub const json_field_names = .{
        .additional_event_types = "AdditionalEventTypes",
        .reporting_mode = "ReportingMode",
    };
};
