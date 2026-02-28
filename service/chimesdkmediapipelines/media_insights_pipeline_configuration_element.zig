const AmazonTranscribeCallAnalyticsProcessorConfiguration = @import("amazon_transcribe_call_analytics_processor_configuration.zig").AmazonTranscribeCallAnalyticsProcessorConfiguration;
const AmazonTranscribeProcessorConfiguration = @import("amazon_transcribe_processor_configuration.zig").AmazonTranscribeProcessorConfiguration;
const KinesisDataStreamSinkConfiguration = @import("kinesis_data_stream_sink_configuration.zig").KinesisDataStreamSinkConfiguration;
const LambdaFunctionSinkConfiguration = @import("lambda_function_sink_configuration.zig").LambdaFunctionSinkConfiguration;
const S3RecordingSinkConfiguration = @import("s3_recording_sink_configuration.zig").S3RecordingSinkConfiguration;
const SnsTopicSinkConfiguration = @import("sns_topic_sink_configuration.zig").SnsTopicSinkConfiguration;
const SqsQueueSinkConfiguration = @import("sqs_queue_sink_configuration.zig").SqsQueueSinkConfiguration;
const MediaInsightsPipelineConfigurationElementType = @import("media_insights_pipeline_configuration_element_type.zig").MediaInsightsPipelineConfigurationElementType;
const VoiceAnalyticsProcessorConfiguration = @import("voice_analytics_processor_configuration.zig").VoiceAnalyticsProcessorConfiguration;
const VoiceEnhancementSinkConfiguration = @import("voice_enhancement_sink_configuration.zig").VoiceEnhancementSinkConfiguration;

/// An element in a media insights pipeline configuration.
pub const MediaInsightsPipelineConfigurationElement = struct {
    /// The analytics configuration settings for transcribing audio in a media
    /// insights pipeline configuration element.
    amazon_transcribe_call_analytics_processor_configuration: ?AmazonTranscribeCallAnalyticsProcessorConfiguration,

    /// The transcription processor configuration settings in a media insights
    /// pipeline
    /// configuration element.
    amazon_transcribe_processor_configuration: ?AmazonTranscribeProcessorConfiguration,

    /// The configuration settings for the Kinesis Data Stream Sink in a media
    /// insights pipeline configuration element.
    kinesis_data_stream_sink_configuration: ?KinesisDataStreamSinkConfiguration,

    /// The configuration settings for the Amazon Web Services Lambda sink in a
    /// media insights pipeline configuration element.
    lambda_function_sink_configuration: ?LambdaFunctionSinkConfiguration,

    /// The configuration settings for the Amazon S3 recording bucket in a media
    /// insights pipeline configuration element.
    s3_recording_sink_configuration: ?S3RecordingSinkConfiguration,

    /// The configuration settings for an SNS topic sink in a media insights
    /// pipeline configuration element.
    sns_topic_sink_configuration: ?SnsTopicSinkConfiguration,

    /// The configuration settings for an SQS queue sink in a media insights
    /// pipeline configuration element.
    sqs_queue_sink_configuration: ?SqsQueueSinkConfiguration,

    /// The element type.
    type: MediaInsightsPipelineConfigurationElementType,

    /// The voice analytics configuration settings in a media insights pipeline
    /// configuration element.
    voice_analytics_processor_configuration: ?VoiceAnalyticsProcessorConfiguration,

    /// The configuration settings for voice enhancement sink in a media insights
    /// pipeline configuration element.
    voice_enhancement_sink_configuration: ?VoiceEnhancementSinkConfiguration,

    pub const json_field_names = .{
        .amazon_transcribe_call_analytics_processor_configuration = "AmazonTranscribeCallAnalyticsProcessorConfiguration",
        .amazon_transcribe_processor_configuration = "AmazonTranscribeProcessorConfiguration",
        .kinesis_data_stream_sink_configuration = "KinesisDataStreamSinkConfiguration",
        .lambda_function_sink_configuration = "LambdaFunctionSinkConfiguration",
        .s3_recording_sink_configuration = "S3RecordingSinkConfiguration",
        .sns_topic_sink_configuration = "SnsTopicSinkConfiguration",
        .sqs_queue_sink_configuration = "SqsQueueSinkConfiguration",
        .type = "Type",
        .voice_analytics_processor_configuration = "VoiceAnalyticsProcessorConfiguration",
        .voice_enhancement_sink_configuration = "VoiceEnhancementSinkConfiguration",
    };
};
