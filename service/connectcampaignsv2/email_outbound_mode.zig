const AgentlessConfig = @import("agentless_config.zig").AgentlessConfig;

/// Email Outbound Mode
pub const EmailOutboundMode = union(enum) {
    agentless: ?AgentlessConfig,

    pub const json_field_names = .{
        .agentless = "agentless",
    };
};
