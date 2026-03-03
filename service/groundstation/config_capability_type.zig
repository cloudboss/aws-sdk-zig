const std = @import("std");

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
        .antenna_downlink = "antenna-downlink",
        .antenna_downlink_demod_decode = "antenna-downlink-demod-decode",
        .tracking = "tracking",
        .dataflow_endpoint = "dataflow-endpoint",
        .antenna_uplink = "antenna-uplink",
        .uplink_echo = "uplink-echo",
        .s3_recording = "s3-recording",
        .telemetry_sink = "telemetry-sink",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .antenna_downlink => "antenna-downlink",
            .antenna_downlink_demod_decode => "antenna-downlink-demod-decode",
            .tracking => "tracking",
            .dataflow_endpoint => "dataflow-endpoint",
            .antenna_uplink => "antenna-uplink",
            .uplink_echo => "uplink-echo",
            .s3_recording => "s3-recording",
            .telemetry_sink => "telemetry-sink",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
