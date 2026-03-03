const EmailOutboundConfig = @import("email_outbound_config.zig").EmailOutboundConfig;
const EmailOutboundMode = @import("email_outbound_mode.zig").EmailOutboundMode;

/// Email Channel Subtype config
pub const EmailChannelSubtypeConfig = struct {
    capacity: ?f64 = null,

    default_outbound_config: EmailOutboundConfig,

    outbound_mode: EmailOutboundMode,

    pub const json_field_names = .{
        .capacity = "capacity",
        .default_outbound_config = "defaultOutboundConfig",
        .outbound_mode = "outboundMode",
    };
};
