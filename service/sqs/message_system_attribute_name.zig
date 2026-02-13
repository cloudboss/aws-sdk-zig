pub const MessageSystemAttributeName = enum {
    all,
    sender_id,
    sent_timestamp,
    approximate_receive_count,
    approximate_first_receive_timestamp,
    sequence_number,
    message_deduplication_id,
    message_group_id,
    aws_trace_header,
    dead_letter_queue_source_arn,

    pub const json_field_names = .{
        .all = "All",
        .sender_id = "SenderId",
        .sent_timestamp = "SentTimestamp",
        .approximate_receive_count = "ApproximateReceiveCount",
        .approximate_first_receive_timestamp = "ApproximateFirstReceiveTimestamp",
        .sequence_number = "SequenceNumber",
        .message_deduplication_id = "MessageDeduplicationId",
        .message_group_id = "MessageGroupId",
        .aws_trace_header = "AWSTraceHeader",
        .dead_letter_queue_source_arn = "DeadLetterQueueSourceArn",
    };
};
