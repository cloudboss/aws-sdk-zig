const DynamoDBAction = @import("dynamo_db_action.zig").DynamoDBAction;
const DynamoDBv2Action = @import("dynamo_d_bv_2_action.zig").DynamoDBv2Action;
const FirehoseAction = @import("firehose_action.zig").FirehoseAction;
const IotEventsAction = @import("iot_events_action.zig").IotEventsAction;
const IotSiteWiseAction = @import("iot_site_wise_action.zig").IotSiteWiseAction;
const IotTopicPublishAction = @import("iot_topic_publish_action.zig").IotTopicPublishAction;
const LambdaAction = @import("lambda_action.zig").LambdaAction;
const SNSTopicPublishAction = @import("sns_topic_publish_action.zig").SNSTopicPublishAction;
const SqsAction = @import("sqs_action.zig").SqsAction;

/// Specifies one of the following actions to receive notifications when the
/// alarm state
/// changes.
pub const AlarmAction = struct {
    dynamo_db: ?DynamoDBAction,

    dynamo_d_bv_2: ?DynamoDBv2Action,

    firehose: ?FirehoseAction,

    iot_events: ?IotEventsAction,

    iot_site_wise: ?IotSiteWiseAction,

    iot_topic_publish: ?IotTopicPublishAction,

    lambda: ?LambdaAction,

    sns: ?SNSTopicPublishAction,

    sqs: ?SqsAction,

    pub const json_field_names = .{
        .dynamo_db = "dynamoDB",
        .dynamo_d_bv_2 = "dynamoDBv2",
        .firehose = "firehose",
        .iot_events = "iotEvents",
        .iot_site_wise = "iotSiteWise",
        .iot_topic_publish = "iotTopicPublish",
        .lambda = "lambda",
        .sns = "sns",
        .sqs = "sqs",
    };
};
