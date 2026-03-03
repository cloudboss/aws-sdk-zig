const aws = @import("aws");

const MessageAttributeValue = @import("message_attribute_value.zig").MessageAttributeValue;

/// An Amazon SQS message.
pub const Message = struct {
    /// A map of the attributes requested in `
    /// ReceiveMessage
    /// ` to
    /// their respective values. Supported attributes:
    ///
    /// * `ApproximateReceiveCount`
    ///
    /// * `ApproximateFirstReceiveTimestamp`
    ///
    /// * `MessageDeduplicationId`
    ///
    /// * `MessageGroupId`
    ///
    /// * `SenderId`
    ///
    /// * `SentTimestamp`
    ///
    /// * `SequenceNumber`
    ///
    /// `ApproximateFirstReceiveTimestamp` and `SentTimestamp` are each
    /// returned as an integer representing the [epoch
    /// time](http://en.wikipedia.org/wiki/Unix_time) in
    /// milliseconds.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// The message's contents (not URL-encoded).
    body: ?[]const u8 = null,

    /// An MD5 digest of the non-URL-encoded message body string.
    md5_of_body: ?[]const u8 = null,

    /// An MD5 digest of the non-URL-encoded message attribute string. You can use
    /// this attribute to verify that Amazon SQS received the message correctly.
    /// Amazon SQS URL-decodes the message before creating the MD5 digest. For
    /// information about MD5, see [RFC1321](https://www.ietf.org/rfc/rfc1321.txt).
    md5_of_message_attributes: ?[]const u8 = null,

    /// Each message attribute consists of a `Name`, `Type`,
    /// and `Value`. For more information, see
    /// [Amazon SQS
    /// message
    /// attributes](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-message-metadata.html#sqs-message-attributes) in the *Amazon SQS Developer Guide*.
    message_attributes: ?[]const aws.map.MapEntry(MessageAttributeValue) = null,

    /// A unique identifier for the message. A `MessageId`is considered unique
    /// across all Amazon Web Services accounts for an extended period of time.
    message_id: ?[]const u8 = null,

    /// An identifier associated with the act of receiving the message. A new
    /// receipt handle
    /// is returned every time you receive a message. When deleting a message, you
    /// provide the
    /// last received receipt handle to delete the message.
    receipt_handle: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .body = "Body",
        .md5_of_body = "MD5OfBody",
        .md5_of_message_attributes = "MD5OfMessageAttributes",
        .message_attributes = "MessageAttributes",
        .message_id = "MessageId",
        .receipt_handle = "ReceiptHandle",
    };
};
