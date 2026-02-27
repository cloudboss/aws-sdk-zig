pub const ConfigCapabilityType = enum {
    antenna_downlink,
    antenna_downlink_demod_decode,
    tracking,
    dataflow_endpoint,
    antenna_uplink,
    uplink_echo,
    s3_recording,
    telemetry_sink,

    pub const json_field_names = .{
        .antenna_downlink = "ANTENNA_DOWNLINK",
        .antenna_downlink_demod_decode = "ANTENNA_DOWNLINK_DEMOD_DECODE",
        .tracking = "TRACKING",
        .dataflow_endpoint = "DATAFLOW_ENDPOINT",
        .antenna_uplink = "ANTENNA_UPLINK",
        .uplink_echo = "UPLINK_ECHO",
        .s3_recording = "S3_RECORDING",
        .telemetry_sink = "TELEMETRY_SINK",
    };
};
