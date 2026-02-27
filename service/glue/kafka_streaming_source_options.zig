/// Additional options for streaming.
pub const KafkaStreamingSourceOptions = struct {
    /// When this option is set to 'true', the data output will contain an
    /// additional column named "__src_timestamp" that indicates the time when the
    /// corresponding record received by the topic. The default value is 'false'.
    /// This option is supported in Glue version 4.0 or later.
    add_record_timestamp: ?[]const u8,

    /// The specific `TopicPartitions` to consume. You must specify at least one of
    /// `"topicName"`, `"assign"` or `"subscribePattern"`.
    assign: ?[]const u8,

    /// A list of bootstrap server URLs, for example, as
    /// `b-1.vpc-test-2.o4q88o.c6.kafka.us-east-1.amazonaws.com:9094`. This option
    /// must be specified in the API call or defined in the table metadata in the
    /// Data Catalog.
    bootstrap_servers: ?[]const u8,

    /// An optional classification.
    classification: ?[]const u8,

    /// The name of the connection.
    connection_name: ?[]const u8,

    /// Specifies the delimiter character.
    delimiter: ?[]const u8,

    /// When this option is set to 'true', for each batch, it will emit the metrics
    /// for the duration between the oldest record received by the topic and the
    /// time it arrives in Glue to CloudWatch. The metric's name is
    /// "glue.driver.streaming.maxConsumerLagInMs". The default value is 'false'.
    /// This option is supported in Glue version 4.0 or later.
    emit_consumer_lag_metrics: ?[]const u8,

    /// The end point when a batch query is ended. Possible values are either
    /// `"latest"` or a JSON string that specifies an ending offset for each
    /// `TopicPartition`.
    ending_offsets: ?[]const u8,

    /// Whether to include the Kafka headers. When the option is set to "true", the
    /// data output will contain an additional column named
    /// "glue_streaming_kafka_headers"
    /// with type `Array[Struct(key: String, value: String)]`. The default value is
    /// "false".
    /// This option is available in Glue version 3.0 or later only.
    include_headers: ?bool,

    /// The rate limit on the maximum number of offsets that are processed per
    /// trigger interval. The specified total number of offsets is proportionally
    /// split across `topicPartitions` of different volumes. The default value is
    /// null, which means that the consumer reads all offsets until the known latest
    /// offset.
    max_offsets_per_trigger: ?i64,

    /// The desired minimum number of partitions to read from Kafka. The default
    /// value is null, which means that the number of spark partitions is equal to
    /// the number of Kafka partitions.
    min_partitions: ?i32,

    /// The number of times to retry before failing to fetch Kafka offsets. The
    /// default value is `3`.
    num_retries: ?i32,

    /// The timeout in milliseconds to poll data from Kafka in Spark job executors.
    /// The default value is `512`.
    poll_timeout_ms: ?i64,

    /// The time in milliseconds to wait before retrying to fetch Kafka offsets. The
    /// default value is `10`.
    retry_interval_ms: ?i64,

    /// The protocol used to communicate with brokers. The possible values are
    /// `"SSL"` or `"PLAINTEXT"`.
    security_protocol: ?[]const u8,

    /// The starting position in the Kafka topic to read data from. The possible
    /// values are `"earliest"` or `"latest"`. The default value is `"latest"`.
    starting_offsets: ?[]const u8,

    /// The timestamp of the record in the Kafka topic to start reading data from.
    /// The possible values are a timestamp string in UTC format of the pattern
    /// `yyyy-mm-ddTHH:MM:SSZ` (where Z represents a UTC timezone offset with a +/-.
    /// For example: "2023-04-04T08:00:00+08:00").
    ///
    /// Only one of `StartingTimestamp` or `StartingOffsets` must be set.
    starting_timestamp: ?i64,

    /// A Java regex string that identifies the topic list to subscribe to. You must
    /// specify at least one of `"topicName"`, `"assign"` or `"subscribePattern"`.
    subscribe_pattern: ?[]const u8,

    /// The topic name as specified in Apache Kafka. You must specify at least one
    /// of `"topicName"`, `"assign"` or `"subscribePattern"`.
    topic_name: ?[]const u8,

    pub const json_field_names = .{
        .add_record_timestamp = "AddRecordTimestamp",
        .assign = "Assign",
        .bootstrap_servers = "BootstrapServers",
        .classification = "Classification",
        .connection_name = "ConnectionName",
        .delimiter = "Delimiter",
        .emit_consumer_lag_metrics = "EmitConsumerLagMetrics",
        .ending_offsets = "EndingOffsets",
        .include_headers = "IncludeHeaders",
        .max_offsets_per_trigger = "MaxOffsetsPerTrigger",
        .min_partitions = "MinPartitions",
        .num_retries = "NumRetries",
        .poll_timeout_ms = "PollTimeoutMs",
        .retry_interval_ms = "RetryIntervalMs",
        .security_protocol = "SecurityProtocol",
        .starting_offsets = "StartingOffsets",
        .starting_timestamp = "StartingTimestamp",
        .subscribe_pattern = "SubscribePattern",
        .topic_name = "TopicName",
    };
};
