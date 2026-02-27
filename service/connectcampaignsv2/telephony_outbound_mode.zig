const AgentlessConfig = @import("agentless_config.zig").AgentlessConfig;
const PredictiveConfig = @import("predictive_config.zig").PredictiveConfig;
const PreviewConfig = @import("preview_config.zig").PreviewConfig;
const ProgressiveConfig = @import("progressive_config.zig").ProgressiveConfig;

/// Telephony Outbound Mode
pub const TelephonyOutboundMode = union(enum) {
    agentless: ?AgentlessConfig,
    predictive: ?PredictiveConfig,
    preview: ?PreviewConfig,
    progressive: ?ProgressiveConfig,

    pub const json_field_names = .{
        .agentless = "agentless",
        .predictive = "predictive",
        .preview = "preview",
        .progressive = "progressive",
    };
};
