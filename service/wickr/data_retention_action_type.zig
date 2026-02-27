pub const DataRetentionActionType = enum {
    enable,
    disable,
    pubkey_msg_ack,

    pub const json_field_names = .{
        .enable = "ENABLE",
        .disable = "DISABLE",
        .pubkey_msg_ack = "PUBKEY_MSG_ACK",
    };
};
