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
        .amazon_transcribe_call_analytics_processor = "AMAZON_TRANSCRIBE_CALL_ANALYTICS_PROCESSOR",
        .voice_analytics_processor = "VOICE_ANALYTICS_PROCESSOR",
        .amazon_transcribe_processor = "AMAZON_TRANSCRIBE_PROCESSOR",
        .kinesis_data_stream_sink = "KINESIS_DATA_STREAM_SINK",
        .lambda_function_sink = "LAMBDA_FUNCTION_SINK",
        .sqs_queue_sink = "SQS_QUEUE_SINK",
        .sns_topic_sink = "SNS_TOPIC_SINK",
        .s3_recording_sink = "S3_RECORDING_SINK",
        .voice_enhancement_sink = "VOICE_ENHANCEMENT_SINK",
    };
};
