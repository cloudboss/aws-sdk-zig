const StartingPosition = @import("starting_position.zig").StartingPosition;

/// Additional options for the Amazon Kinesis streaming data source.
pub const KinesisStreamingSourceOptions = struct {
    /// Adds a time delay between two consecutive getRecords operations. The default
    /// value is `"False"`. This option is only configurable for Glue version 2.0
    /// and above.
    add_idle_time_between_reads: ?bool,

    /// When this option is set to 'true', the data output will contain an
    /// additional column named "__src_timestamp" that indicates the time when the
    /// corresponding record received by the stream. The default value is 'false'.
    /// This option is supported in Glue version 4.0 or later.
    add_record_timestamp: ?[]const u8,

    /// Avoids creating an empty microbatch job by checking for unread data in the
    /// Kinesis data stream before the batch is started. The default value is
    /// `"False"`.
    avoid_empty_batches: ?bool,

    /// An optional classification.
    classification: ?[]const u8,

    /// Specifies the delimiter character.
    delimiter: ?[]const u8,

    /// The minimum time interval between two ListShards API calls for your script
    /// to consider resharding. The default value is `1s`.
    describe_shard_interval: ?i64,

    /// When this option is set to 'true', for each batch, it will emit the metrics
    /// for the duration between the oldest record received by the stream and the
    /// time it arrives in Glue to CloudWatch. The metric's name is
    /// "glue.driver.streaming.maxConsumerLagInMs". The default value is 'false'.
    /// This option is supported in Glue version 4.0 or later.
    emit_consumer_lag_metrics: ?[]const u8,

    /// The URL of the Kinesis endpoint.
    endpoint_url: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the Kinesis Data Streams enhanced fan-out
    /// consumer. When specified, enables enhanced fan-out for
    /// dedicated throughput and lower latency data consumption.
    fanout_consumer_arn: ?[]const u8,

    /// The minimum time delay between two consecutive getRecords operations,
    /// specified in ms. The default value is `1000`. This option is only
    /// configurable for Glue version 2.0 and above.
    idle_time_between_reads_in_ms: ?i64,

    /// The maximum number of records to fetch per shard in the Kinesis data stream
    /// per microbatch. Note: The client can exceed this limit if the streaming job
    /// has already read extra records from Kinesis (in the same get-records call).
    /// If `MaxFetchRecordsPerShard` needs to be strict then it needs to be a
    /// multiple of `MaxRecordPerRead`. The default value is `100000`.
    max_fetch_records_per_shard: ?i64,

    /// The maximum time spent for the job executor to read records for the current
    /// batch from the Kinesis data stream, specified in milliseconds (ms). Multiple
    /// `GetRecords` API calls may be made within this time. The default value is
    /// `1000`.
    max_fetch_time_in_ms: ?i64,

    /// The maximum number of records to fetch from the Kinesis data stream in each
    /// getRecords operation. The default value is `10000`.
    max_record_per_read: ?i64,

    /// The maximum cool-off time period (specified in ms) between two retries of a
    /// Kinesis Data Streams API call. The default value is `10000`.
    max_retry_interval_ms: ?i64,

    /// The maximum number of retries for Kinesis Data Streams API requests. The
    /// default value is `3`.
    num_retries: ?i32,

    /// The cool-off time period (specified in ms) before retrying the Kinesis Data
    /// Streams API call. The default value is `1000`.
    retry_interval_ms: ?i64,

    /// The Amazon Resource Name (ARN) of the role to assume using AWS Security
    /// Token Service (AWS STS). This role must have permissions for describe or
    /// read record operations for the Kinesis data stream. You must use this
    /// parameter when accessing a data stream in a different account. Used in
    /// conjunction with `"awsSTSSessionName"`.
    role_arn: ?[]const u8,

    /// An identifier for the session assuming the role using AWS STS. You must use
    /// this parameter when accessing a data stream in a different account. Used in
    /// conjunction with `"awsSTSRoleARN"`.
    role_session_name: ?[]const u8,

    /// The starting position in the Kinesis data stream to read data from. The
    /// possible values are `"latest"`, `"trim_horizon"`, `"earliest"`, or a
    /// timestamp string in UTC format in the pattern `yyyy-mm-ddTHH:MM:SSZ` (where
    /// `Z` represents a UTC timezone offset with a +/-. For example:
    /// "2023-04-04T08:00:00-04:00"). The default value is `"latest"`.
    ///
    /// Note: Using a value that is a timestamp string in UTC format for
    /// "startingPosition" is supported only for Glue version 4.0 or later.
    starting_position: ?StartingPosition,

    /// The timestamp of the record in the Kinesis data stream to start reading data
    /// from. The possible values are a timestamp string in UTC format of the
    /// pattern `yyyy-mm-ddTHH:MM:SSZ` (where Z represents a UTC timezone offset
    /// with a +/-. For example: "2023-04-04T08:00:00+08:00").
    starting_timestamp: ?i64,

    /// The Amazon Resource Name (ARN) of the Kinesis data stream.
    stream_arn: ?[]const u8,

    /// The name of the Kinesis data stream.
    stream_name: ?[]const u8,

    pub const json_field_names = .{
        .add_idle_time_between_reads = "AddIdleTimeBetweenReads",
        .add_record_timestamp = "AddRecordTimestamp",
        .avoid_empty_batches = "AvoidEmptyBatches",
        .classification = "Classification",
        .delimiter = "Delimiter",
        .describe_shard_interval = "DescribeShardInterval",
        .emit_consumer_lag_metrics = "EmitConsumerLagMetrics",
        .endpoint_url = "EndpointUrl",
        .fanout_consumer_arn = "FanoutConsumerARN",
        .idle_time_between_reads_in_ms = "IdleTimeBetweenReadsInMs",
        .max_fetch_records_per_shard = "MaxFetchRecordsPerShard",
        .max_fetch_time_in_ms = "MaxFetchTimeInMs",
        .max_record_per_read = "MaxRecordPerRead",
        .max_retry_interval_ms = "MaxRetryIntervalMs",
        .num_retries = "NumRetries",
        .retry_interval_ms = "RetryIntervalMs",
        .role_arn = "RoleArn",
        .role_session_name = "RoleSessionName",
        .starting_position = "StartingPosition",
        .starting_timestamp = "StartingTimestamp",
        .stream_arn = "StreamArn",
        .stream_name = "StreamName",
    };
};
