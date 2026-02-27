const AntennaDownlinkConfig = @import("antenna_downlink_config.zig").AntennaDownlinkConfig;
const AntennaDownlinkDemodDecodeConfig = @import("antenna_downlink_demod_decode_config.zig").AntennaDownlinkDemodDecodeConfig;
const AntennaUplinkConfig = @import("antenna_uplink_config.zig").AntennaUplinkConfig;
const DataflowEndpointConfig = @import("dataflow_endpoint_config.zig").DataflowEndpointConfig;
const S3RecordingConfig = @import("s3_recording_config.zig").S3RecordingConfig;
const TelemetrySinkConfig = @import("telemetry_sink_config.zig").TelemetrySinkConfig;
const TrackingConfig = @import("tracking_config.zig").TrackingConfig;
const UplinkEchoConfig = @import("uplink_echo_config.zig").UplinkEchoConfig;

/// Object containing the parameters of a `Config`.
///
/// See the subtype definitions for what each type of `Config` contains.
pub const ConfigTypeData = union(enum) {
    /// Information about how AWS Ground Station should configure an antenna for
    /// downlink during a contact.
    antenna_downlink_config: ?AntennaDownlinkConfig,
    /// Information about how AWS Ground Station should conﬁgure an antenna for
    /// downlink demod decode during a contact.
    antenna_downlink_demod_decode_config: ?AntennaDownlinkDemodDecodeConfig,
    /// Information about how AWS Ground Station should conﬁgure an antenna for
    /// uplink during a contact.
    antenna_uplink_config: ?AntennaUplinkConfig,
    /// Information about the dataflow endpoint `Config`.
    dataflow_endpoint_config: ?DataflowEndpointConfig,
    /// Information about an S3 recording `Config`.
    s_3_recording_config: ?S3RecordingConfig,
    /// Information about a telemetry sink `Config`.
    telemetry_sink_config: ?TelemetrySinkConfig,
    /// Object that determines whether tracking should be used during a contact
    /// executed with this `Config` in the mission profile.
    tracking_config: ?TrackingConfig,
    /// Information about an uplink echo `Config`.
    ///
    /// Parameters from the `AntennaUplinkConfig`, corresponding to the specified `
    /// AntennaUplinkConfigArn`, are used when this `UplinkEchoConfig` is used in a
    /// contact.
    uplink_echo_config: ?UplinkEchoConfig,

    pub const json_field_names = .{
        .antenna_downlink_config = "antennaDownlinkConfig",
        .antenna_downlink_demod_decode_config = "antennaDownlinkDemodDecodeConfig",
        .antenna_uplink_config = "antennaUplinkConfig",
        .dataflow_endpoint_config = "dataflowEndpointConfig",
        .s_3_recording_config = "s3RecordingConfig",
        .telemetry_sink_config = "telemetrySinkConfig",
        .tracking_config = "trackingConfig",
        .uplink_echo_config = "uplinkEchoConfig",
    };
};
