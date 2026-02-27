pub const ContactInitiationMethod = enum {
    inbound,
    outbound,
    transfer,
    queue_transfer,
    callback,
    api,
    disconnect,
    monitor,
    external_outbound,
    webrtc_api,
    agent_reply,
    flow,

    pub const json_field_names = .{
        .inbound = "INBOUND",
        .outbound = "OUTBOUND",
        .transfer = "TRANSFER",
        .queue_transfer = "QUEUE_TRANSFER",
        .callback = "CALLBACK",
        .api = "API",
        .disconnect = "DISCONNECT",
        .monitor = "MONITOR",
        .external_outbound = "EXTERNAL_OUTBOUND",
        .webrtc_api = "WEBRTC_API",
        .agent_reply = "AGENT_REPLY",
        .flow = "FLOW",
    };
};
