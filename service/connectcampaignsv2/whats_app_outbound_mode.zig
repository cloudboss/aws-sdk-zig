const AgentlessConfig = @import("agentless_config.zig").AgentlessConfig;

/// WhatsApp Outbound Mode
pub const WhatsAppOutboundMode = union(enum) {
    agentless: ?AgentlessConfig,

    pub const json_field_names = .{
        .agentless = "agentless",
    };
};
