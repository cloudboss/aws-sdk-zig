const std = @import("std");

pub const QueueAttributeName = enum {
    all,
    policy,
    visibility_timeout,
    maximum_message_size,
    message_retention_period,
    approximate_number_of_messages,
    approximate_number_of_messages_not_visible,
    created_timestamp,
    last_modified_timestamp,
    queue_arn,
    approximate_number_of_messages_delayed,
    delay_seconds,
    receive_message_wait_time_seconds,
    redrive_policy,
    fifo_queue,
    content_based_deduplication,
    kms_master_key_id,
    kms_data_key_reuse_period_seconds,
    deduplication_scope,
    fifo_throughput_limit,
    redrive_allow_policy,
    sqs_managed_sse_enabled,

    pub const json_field_names = .{
        .all = "All",
        .policy = "Policy",
        .visibility_timeout = "VisibilityTimeout",
        .maximum_message_size = "MaximumMessageSize",
        .message_retention_period = "MessageRetentionPeriod",
        .approximate_number_of_messages = "ApproximateNumberOfMessages",
        .approximate_number_of_messages_not_visible = "ApproximateNumberOfMessagesNotVisible",
        .created_timestamp = "CreatedTimestamp",
        .last_modified_timestamp = "LastModifiedTimestamp",
        .queue_arn = "QueueArn",
        .approximate_number_of_messages_delayed = "ApproximateNumberOfMessagesDelayed",
        .delay_seconds = "DelaySeconds",
        .receive_message_wait_time_seconds = "ReceiveMessageWaitTimeSeconds",
        .redrive_policy = "RedrivePolicy",
        .fifo_queue = "FifoQueue",
        .content_based_deduplication = "ContentBasedDeduplication",
        .kms_master_key_id = "KmsMasterKeyId",
        .kms_data_key_reuse_period_seconds = "KmsDataKeyReusePeriodSeconds",
        .deduplication_scope = "DeduplicationScope",
        .fifo_throughput_limit = "FifoThroughputLimit",
        .redrive_allow_policy = "RedriveAllowPolicy",
        .sqs_managed_sse_enabled = "SqsManagedSseEnabled",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all => "All",
            .policy => "Policy",
            .visibility_timeout => "VisibilityTimeout",
            .maximum_message_size => "MaximumMessageSize",
            .message_retention_period => "MessageRetentionPeriod",
            .approximate_number_of_messages => "ApproximateNumberOfMessages",
            .approximate_number_of_messages_not_visible => "ApproximateNumberOfMessagesNotVisible",
            .created_timestamp => "CreatedTimestamp",
            .last_modified_timestamp => "LastModifiedTimestamp",
            .queue_arn => "QueueArn",
            .approximate_number_of_messages_delayed => "ApproximateNumberOfMessagesDelayed",
            .delay_seconds => "DelaySeconds",
            .receive_message_wait_time_seconds => "ReceiveMessageWaitTimeSeconds",
            .redrive_policy => "RedrivePolicy",
            .fifo_queue => "FifoQueue",
            .content_based_deduplication => "ContentBasedDeduplication",
            .kms_master_key_id => "KmsMasterKeyId",
            .kms_data_key_reuse_period_seconds => "KmsDataKeyReusePeriodSeconds",
            .deduplication_scope => "DeduplicationScope",
            .fifo_throughput_limit => "FifoThroughputLimit",
            .redrive_allow_policy => "RedriveAllowPolicy",
            .sqs_managed_sse_enabled => "SqsManagedSseEnabled",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
