const std = @import("std");

pub const MediaInsightsPipelineConfigurationElementType = enum {
    amazon_transcribe_call_analytics_processor,
    voice_analytics_processor,
    amazon_transcribe_processor,
    kinesis_data_stream_sink,
    lambda_function_sink,
    sqs_queue_sink,
    sns_topic_sink,
    s3_recording_sink,
    voice_enhancement_sink,

    pub const json_field_names = .{
        .amazon_transcribe_call_analytics_processor = "AmazonTranscribeCallAnalyticsProcessor",
        .voice_analytics_processor = "VoiceAnalyticsProcessor",
        .amazon_transcribe_processor = "AmazonTranscribeProcessor",
        .kinesis_data_stream_sink = "KinesisDataStreamSink",
        .lambda_function_sink = "LambdaFunctionSink",
        .sqs_queue_sink = "SqsQueueSink",
        .sns_topic_sink = "SnsTopicSink",
        .s3_recording_sink = "S3RecordingSink",
        .voice_enhancement_sink = "VoiceEnhancementSink",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .amazon_transcribe_call_analytics_processor => "AmazonTranscribeCallAnalyticsProcessor",
            .voice_analytics_processor => "VoiceAnalyticsProcessor",
            .amazon_transcribe_processor => "AmazonTranscribeProcessor",
            .kinesis_data_stream_sink => "KinesisDataStreamSink",
            .lambda_function_sink => "LambdaFunctionSink",
            .sqs_queue_sink => "SqsQueueSink",
            .sns_topic_sink => "SnsTopicSink",
            .s3_recording_sink => "S3RecordingSink",
            .voice_enhancement_sink => "VoiceEnhancementSink",
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
