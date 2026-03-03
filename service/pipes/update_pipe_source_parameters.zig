const UpdatePipeSourceActiveMQBrokerParameters = @import("update_pipe_source_active_mq_broker_parameters.zig").UpdatePipeSourceActiveMQBrokerParameters;
const UpdatePipeSourceDynamoDBStreamParameters = @import("update_pipe_source_dynamo_db_stream_parameters.zig").UpdatePipeSourceDynamoDBStreamParameters;
const FilterCriteria = @import("filter_criteria.zig").FilterCriteria;
const UpdatePipeSourceKinesisStreamParameters = @import("update_pipe_source_kinesis_stream_parameters.zig").UpdatePipeSourceKinesisStreamParameters;
const UpdatePipeSourceManagedStreamingKafkaParameters = @import("update_pipe_source_managed_streaming_kafka_parameters.zig").UpdatePipeSourceManagedStreamingKafkaParameters;
const UpdatePipeSourceRabbitMQBrokerParameters = @import("update_pipe_source_rabbit_mq_broker_parameters.zig").UpdatePipeSourceRabbitMQBrokerParameters;
const UpdatePipeSourceSelfManagedKafkaParameters = @import("update_pipe_source_self_managed_kafka_parameters.zig").UpdatePipeSourceSelfManagedKafkaParameters;
const UpdatePipeSourceSqsQueueParameters = @import("update_pipe_source_sqs_queue_parameters.zig").UpdatePipeSourceSqsQueueParameters;

/// The parameters required to set up a source for your pipe.
pub const UpdatePipeSourceParameters = struct {
    /// The parameters for using an Active MQ broker as a source.
    active_mq_broker_parameters: ?UpdatePipeSourceActiveMQBrokerParameters = null,

    /// The parameters for using a DynamoDB stream as a source.
    dynamo_db_stream_parameters: ?UpdatePipeSourceDynamoDBStreamParameters = null,

    /// The collection of event patterns used to filter events.
    ///
    /// To remove a filter, specify a `FilterCriteria` object with an empty array of
    /// `Filter` objects.
    ///
    /// For more information, see [Events and Event
    /// Patterns](https://docs.aws.amazon.com/eventbridge/latest/userguide/eventbridge-and-event-patterns.html) in the *Amazon EventBridge User Guide*.
    filter_criteria: ?FilterCriteria = null,

    /// The parameters for using a Kinesis stream as a source.
    kinesis_stream_parameters: ?UpdatePipeSourceKinesisStreamParameters = null,

    /// The parameters for using an MSK stream as a source.
    managed_streaming_kafka_parameters: ?UpdatePipeSourceManagedStreamingKafkaParameters = null,

    /// The parameters for using a Rabbit MQ broker as a source.
    rabbit_mq_broker_parameters: ?UpdatePipeSourceRabbitMQBrokerParameters = null,

    /// The parameters for using a self-managed Apache Kafka stream as a source.
    ///
    /// A *self managed* cluster refers to any Apache Kafka cluster not hosted by
    /// Amazon Web Services.
    /// This includes both clusters you manage yourself, as well as those hosted by
    /// a third-party
    /// provider, such as [Confluent
    /// Cloud](https://www.confluent.io/),
    /// [CloudKarafka](https://www.cloudkarafka.com/), or
    /// [Redpanda](https://redpanda.com/). For more information, see [Apache Kafka
    /// streams as a
    /// source](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-pipes-kafka.html) in the *Amazon EventBridge User Guide*.
    self_managed_kafka_parameters: ?UpdatePipeSourceSelfManagedKafkaParameters = null,

    /// The parameters for using a Amazon SQS stream as a source.
    sqs_queue_parameters: ?UpdatePipeSourceSqsQueueParameters = null,

    pub const json_field_names = .{
        .active_mq_broker_parameters = "ActiveMQBrokerParameters",
        .dynamo_db_stream_parameters = "DynamoDBStreamParameters",
        .filter_criteria = "FilterCriteria",
        .kinesis_stream_parameters = "KinesisStreamParameters",
        .managed_streaming_kafka_parameters = "ManagedStreamingKafkaParameters",
        .rabbit_mq_broker_parameters = "RabbitMQBrokerParameters",
        .self_managed_kafka_parameters = "SelfManagedKafkaParameters",
        .sqs_queue_parameters = "SqsQueueParameters",
    };
};
