const TelephonyOutboundConfig = @import("telephony_outbound_config.zig").TelephonyOutboundConfig;
const TelephonyOutboundMode = @import("telephony_outbound_mode.zig").TelephonyOutboundMode;

/// Telephony Channel Subtype config
pub const TelephonyChannelSubtypeConfig = struct {
    capacity: ?f64 = null,

    connect_queue_id: ?[]const u8 = null,

    default_outbound_config: TelephonyOutboundConfig,

    outbound_mode: TelephonyOutboundMode,

    pub const json_field_names = .{
        .capacity = "capacity",
        .connect_queue_id = "connectQueueId",
        .default_outbound_config = "defaultOutboundConfig",
        .outbound_mode = "outboundMode",
    };
};
