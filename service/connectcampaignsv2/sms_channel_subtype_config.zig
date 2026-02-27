const SmsOutboundConfig = @import("sms_outbound_config.zig").SmsOutboundConfig;
const SmsOutboundMode = @import("sms_outbound_mode.zig").SmsOutboundMode;

/// SMS Channel Subtype config
pub const SmsChannelSubtypeConfig = struct {
    capacity: ?f64,

    default_outbound_config: SmsOutboundConfig,

    outbound_mode: SmsOutboundMode,

    pub const json_field_names = .{
        .capacity = "capacity",
        .default_outbound_config = "defaultOutboundConfig",
        .outbound_mode = "outboundMode",
    };
};
