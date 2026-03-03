const WhatsAppOutboundConfig = @import("whats_app_outbound_config.zig").WhatsAppOutboundConfig;
const WhatsAppOutboundMode = @import("whats_app_outbound_mode.zig").WhatsAppOutboundMode;

/// WhatsApp Channel Subtype config
pub const WhatsAppChannelSubtypeConfig = struct {
    capacity: ?f64 = null,

    default_outbound_config: WhatsAppOutboundConfig,

    outbound_mode: WhatsAppOutboundMode,

    pub const json_field_names = .{
        .capacity = "capacity",
        .default_outbound_config = "defaultOutboundConfig",
        .outbound_mode = "outboundMode",
    };
};
