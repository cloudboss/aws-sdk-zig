pub const ChatItemType = enum {
    typing,
    participant_joined,
    participant_left,
    chat_ended,
    transfer_succeeded,
    transfer_failed,
    message,
    event,
    attachment,
    connection_ack,
    message_delivered,
    message_read,

    pub const json_field_names = .{
        .typing = "TYPING",
        .participant_joined = "PARTICIPANT_JOINED",
        .participant_left = "PARTICIPANT_LEFT",
        .chat_ended = "CHAT_ENDED",
        .transfer_succeeded = "TRANSFER_SUCCEEDED",
        .transfer_failed = "TRANSFER_FAILED",
        .message = "MESSAGE",
        .event = "EVENT",
        .attachment = "ATTACHMENT",
        .connection_ack = "CONNECTION_ACK",
        .message_delivered = "MESSAGE_DELIVERED",
        .message_read = "MESSAGE_READ",
    };
};
