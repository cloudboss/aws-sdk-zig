/// Encloses a `MessageId` for a successfully-enqueued message in a `
/// SendMessageBatch.`
pub const SendMessageBatchResultEntry = struct {
    /// An identifier for the message in this batch.
    id: []const u8,

    /// An MD5 digest of the non-URL-encoded message attribute string. You can use
    /// this attribute to verify that Amazon SQS received the message correctly.
    /// Amazon SQS URL-decodes the message before creating the MD5 digest. For
    /// information about MD5, see [RFC1321](https://www.ietf.org/rfc/rfc1321.txt).
    md5_of_message_attributes: ?[]const u8,

    /// An MD5 digest of the non-URL-encoded message body string. You can use this
    /// attribute to verify that Amazon SQS received the message correctly. Amazon
    /// SQS URL-decodes the message before creating the MD5 digest. For information
    /// about MD5, see [RFC1321](https://www.ietf.org/rfc/rfc1321.txt).
    md5_of_message_body: []const u8,

    /// An MD5 digest of the non-URL-encoded message system attribute string. You
    /// can use this
    /// attribute to verify that Amazon SQS received the message correctly. Amazon
    /// SQS URL-decodes the message before creating the MD5 digest. For information
    /// about MD5, see [RFC1321](https://www.ietf.org/rfc/rfc1321.txt).
    md5_of_message_system_attributes: ?[]const u8,

    /// An identifier for the message.
    message_id: []const u8,

    /// This parameter applies only to FIFO (first-in-first-out) queues.
    ///
    /// The large, non-consecutive number that Amazon SQS assigns to each message.
    ///
    /// The length of `SequenceNumber` is 128 bits. As `SequenceNumber`
    /// continues to increase for a particular `MessageGroupId`.
    sequence_number: ?[]const u8,

    pub const json_field_names = .{
        .id = "Id",
        .md5_of_message_attributes = "MD5OfMessageAttributes",
        .md5_of_message_body = "MD5OfMessageBody",
        .md5_of_message_system_attributes = "MD5OfMessageSystemAttributes",
        .message_id = "MessageId",
        .sequence_number = "SequenceNumber",
    };
};
