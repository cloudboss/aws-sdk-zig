/// The details of an Amazon Chime SDK Voice Connector call.
pub const CallDetails = struct {
    /// Identifies a person as the caller or the callee.
    is_caller: ?bool = null,

    /// The transaction ID of a Voice Connector call.
    transaction_id: ?[]const u8 = null,

    /// The Voice Connector ID.
    voice_connector_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .is_caller = "IsCaller",
        .transaction_id = "TransactionId",
        .voice_connector_id = "VoiceConnectorId",
    };
};
