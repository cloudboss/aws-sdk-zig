pub const VoiceConnectorIntegrationType = enum {
    connect_call_transfer_connector,
    connect_analytics_connector,

    pub const json_field_names = .{
        .connect_call_transfer_connector = "CONNECT_CALL_TRANSFER_CONNECTOR",
        .connect_analytics_connector = "CONNECT_ANALYTICS_CONNECTOR",
    };
};
