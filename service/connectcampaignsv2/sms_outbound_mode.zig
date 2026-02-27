const AgentlessConfig = @import("agentless_config.zig").AgentlessConfig;

/// SMS Outbound Mode
pub const SmsOutboundMode = union(enum) {
    agentless: ?AgentlessConfig,

    pub const json_field_names = .{
        .agentless = "agentless",
    };
};
