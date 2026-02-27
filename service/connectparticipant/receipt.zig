/// The receipt for the message delivered to the recipient.
pub const Receipt = struct {
    /// The time when the message was delivered to the recipient.
    delivered_timestamp: ?[]const u8,

    /// The time when the message was read by the recipient.
    read_timestamp: ?[]const u8,

    /// The identifier of the recipient of the message.
    recipient_participant_id: ?[]const u8,

    pub const json_field_names = .{
        .delivered_timestamp = "DeliveredTimestamp",
        .read_timestamp = "ReadTimestamp",
        .recipient_participant_id = "RecipientParticipantId",
    };
};
