const CloudwatchAlarmAction = @import("cloudwatch_alarm_action.zig").CloudwatchAlarmAction;
const CloudwatchLogsAction = @import("cloudwatch_logs_action.zig").CloudwatchLogsAction;
const CloudwatchMetricAction = @import("cloudwatch_metric_action.zig").CloudwatchMetricAction;
const DynamoDBAction = @import("dynamo_db_action.zig").DynamoDBAction;
const DynamoDBv2Action = @import("dynamo_d_bv_2_action.zig").DynamoDBv2Action;
const ElasticsearchAction = @import("elasticsearch_action.zig").ElasticsearchAction;
const FirehoseAction = @import("firehose_action.zig").FirehoseAction;
const HttpAction = @import("http_action.zig").HttpAction;
const IotAnalyticsAction = @import("iot_analytics_action.zig").IotAnalyticsAction;
const IotEventsAction = @import("iot_events_action.zig").IotEventsAction;
const IotSiteWiseAction = @import("iot_site_wise_action.zig").IotSiteWiseAction;
const KafkaAction = @import("kafka_action.zig").KafkaAction;
const KinesisAction = @import("kinesis_action.zig").KinesisAction;
const LambdaAction = @import("lambda_action.zig").LambdaAction;
const LocationAction = @import("location_action.zig").LocationAction;
const OpenSearchAction = @import("open_search_action.zig").OpenSearchAction;
const RepublishAction = @import("republish_action.zig").RepublishAction;
const S3Action = @import("s3_action.zig").S3Action;
const SalesforceAction = @import("salesforce_action.zig").SalesforceAction;
const SnsAction = @import("sns_action.zig").SnsAction;
const SqsAction = @import("sqs_action.zig").SqsAction;
const StepFunctionsAction = @import("step_functions_action.zig").StepFunctionsAction;
const TimestreamAction = @import("timestream_action.zig").TimestreamAction;

/// Describes the actions associated with a rule.
pub const Action = struct {
    /// Change the state of a CloudWatch alarm.
    cloudwatch_alarm: ?CloudwatchAlarmAction,

    /// Send data to CloudWatch Logs.
    cloudwatch_logs: ?CloudwatchLogsAction,

    /// Capture a CloudWatch metric.
    cloudwatch_metric: ?CloudwatchMetricAction,

    /// Write to a DynamoDB table.
    dynamo_db: ?DynamoDBAction,

    /// Write to a DynamoDB table. This is a new version of the DynamoDB action. It
    /// allows
    /// you to write each attribute in an MQTT message payload into a separate
    /// DynamoDB
    /// column.
    dynamo_d_bv_2: ?DynamoDBv2Action,

    /// Write data to an Amazon OpenSearch Service domain.
    ///
    /// The `Elasticsearch` action can only be used by existing rule actions.
    /// To create a new rule action or to update an existing rule action, use the
    /// `OpenSearch` rule action instead. For more information, see
    /// [OpenSearchAction](https://docs.aws.amazon.com/iot/latest/apireference/API_OpenSearchAction.html).
    elasticsearch: ?ElasticsearchAction,

    /// Write to an Amazon Kinesis Firehose stream.
    firehose: ?FirehoseAction,

    /// Send data to an HTTPS endpoint.
    http: ?HttpAction,

    /// Sends message data to an IoT Analytics channel.
    iot_analytics: ?IotAnalyticsAction,

    /// Sends an input to an IoT Events detector.
    iot_events: ?IotEventsAction,

    /// Sends data from the MQTT message that triggered the rule to IoT SiteWise
    /// asset
    /// properties.
    iot_site_wise: ?IotSiteWiseAction,

    /// Send messages to an Amazon Managed Streaming for Apache Kafka (Amazon MSK)
    /// or self-managed Apache Kafka cluster.
    kafka: ?KafkaAction,

    /// Write data to an Amazon Kinesis stream.
    kinesis: ?KinesisAction,

    /// Invoke a Lambda function.
    lambda: ?LambdaAction,

    /// The Amazon Location Service rule action sends device location updates from
    /// an MQTT message to an Amazon Location tracker resource.
    location: ?LocationAction,

    /// Write data to an Amazon OpenSearch Service domain.
    open_search: ?OpenSearchAction,

    /// Publish to another MQTT topic.
    republish: ?RepublishAction,

    /// Write to an Amazon S3 bucket.
    s_3: ?S3Action,

    /// Send a message to a Salesforce IoT Cloud Input Stream.
    salesforce: ?SalesforceAction,

    /// Publish to an Amazon SNS topic.
    sns: ?SnsAction,

    /// Publish to an Amazon SQS queue.
    sqs: ?SqsAction,

    /// Starts execution of a Step Functions state machine.
    step_functions: ?StepFunctionsAction,

    /// The Timestream rule action writes attributes (measures) from an MQTT message
    /// into an Amazon Timestream table. For more information, see the
    /// [Timestream](https://docs.aws.amazon.com/iot/latest/developerguide/timestream-rule-action.html)
    /// topic rule action documentation.
    timestream: ?TimestreamAction,

    pub const json_field_names = .{
        .cloudwatch_alarm = "cloudwatchAlarm",
        .cloudwatch_logs = "cloudwatchLogs",
        .cloudwatch_metric = "cloudwatchMetric",
        .dynamo_db = "dynamoDB",
        .dynamo_d_bv_2 = "dynamoDBv2",
        .elasticsearch = "elasticsearch",
        .firehose = "firehose",
        .http = "http",
        .iot_analytics = "iotAnalytics",
        .iot_events = "iotEvents",
        .iot_site_wise = "iotSiteWise",
        .kafka = "kafka",
        .kinesis = "kinesis",
        .lambda = "lambda",
        .location = "location",
        .open_search = "openSearch",
        .republish = "republish",
        .s_3 = "s3",
        .salesforce = "salesforce",
        .sns = "sns",
        .sqs = "sqs",
        .step_functions = "stepFunctions",
        .timestream = "timestream",
    };
};
