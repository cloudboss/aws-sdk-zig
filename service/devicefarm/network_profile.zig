const NetworkProfileType = @import("network_profile_type.zig").NetworkProfileType;

/// An array of settings that describes characteristics of a network profile.
pub const NetworkProfile = struct {
    /// The Amazon Resource Name (ARN) of the network profile.
    arn: ?[]const u8 = null,

    /// The description of the network profile.
    description: ?[]const u8 = null,

    /// The data throughput rate in bits per second, as an integer from 0 to
    /// 104857600.
    downlink_bandwidth_bits: ?i64 = null,

    /// Delay time for all packets to destination in milliseconds as an integer from
    /// 0 to
    /// 2000.
    downlink_delay_ms: ?i64 = null,

    /// Time variation in the delay of received packets in milliseconds as an
    /// integer from
    /// 0 to 2000.
    downlink_jitter_ms: ?i64 = null,

    /// Proportion of received packets that fail to arrive from 0 to 100 percent.
    downlink_loss_percent: i32 = 0,

    /// The name of the network profile.
    name: ?[]const u8 = null,

    /// The type of network profile. Valid values are listed here.
    @"type": ?NetworkProfileType = null,

    /// The data throughput rate in bits per second, as an integer from 0 to
    /// 104857600.
    uplink_bandwidth_bits: ?i64 = null,

    /// Delay time for all packets to destination in milliseconds as an integer from
    /// 0 to
    /// 2000.
    uplink_delay_ms: ?i64 = null,

    /// Time variation in the delay of received packets in milliseconds as an
    /// integer from
    /// 0 to 2000.
    uplink_jitter_ms: ?i64 = null,

    /// Proportion of transmitted packets that fail to arrive from 0 to 100
    /// percent.
    uplink_loss_percent: i32 = 0,

    pub const json_field_names = .{
        .arn = "arn",
        .description = "description",
        .downlink_bandwidth_bits = "downlinkBandwidthBits",
        .downlink_delay_ms = "downlinkDelayMs",
        .downlink_jitter_ms = "downlinkJitterMs",
        .downlink_loss_percent = "downlinkLossPercent",
        .name = "name",
        .@"type" = "type",
        .uplink_bandwidth_bits = "uplinkBandwidthBits",
        .uplink_delay_ms = "uplinkDelayMs",
        .uplink_jitter_ms = "uplinkJitterMs",
        .uplink_loss_percent = "uplinkLossPercent",
    };
};
