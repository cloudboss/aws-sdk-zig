const ClearTimerAction = @import("clear_timer_action.zig").ClearTimerAction;
const DynamoDBAction = @import("dynamo_db_action.zig").DynamoDBAction;
const DynamoDBv2Action = @import("dynamo_d_bv_2_action.zig").DynamoDBv2Action;
const FirehoseAction = @import("firehose_action.zig").FirehoseAction;
const IotEventsAction = @import("iot_events_action.zig").IotEventsAction;
const IotSiteWiseAction = @import("iot_site_wise_action.zig").IotSiteWiseAction;
const IotTopicPublishAction = @import("iot_topic_publish_action.zig").IotTopicPublishAction;
const LambdaAction = @import("lambda_action.zig").LambdaAction;
const ResetTimerAction = @import("reset_timer_action.zig").ResetTimerAction;
const SetTimerAction = @import("set_timer_action.zig").SetTimerAction;
const SetVariableAction = @import("set_variable_action.zig").SetVariableAction;
const SNSTopicPublishAction = @import("sns_topic_publish_action.zig").SNSTopicPublishAction;
const SqsAction = @import("sqs_action.zig").SqsAction;

/// An action to be performed when the `condition` is TRUE.
pub const Action = struct {
    /// Information needed to clear the timer.
    clear_timer: ?ClearTimerAction = null,

    /// Writes to the DynamoDB table that you created. The default action payload
    /// contains all
    /// attribute-value pairs that have the information about the detector model
    /// instance and the
    /// event that triggered the action. You can customize the
    /// [payload](https://docs.aws.amazon.com/iotevents/latest/apireference/API_Payload.html). One column of the
    /// DynamoDB table receives all attribute-value pairs in the payload that you
    /// specify. For more
    /// information, see
    /// [Actions](https://docs.aws.amazon.com/iotevents/latest/developerguide/iotevents-event-actions.html) in
    /// *AWS IoT Events Developer Guide*.
    dynamo_db: ?DynamoDBAction = null,

    /// Writes to the DynamoDB table that you created. The default action payload
    /// contains all
    /// attribute-value pairs that have the information about the detector model
    /// instance and the
    /// event that triggered the action. You can customize the
    /// [payload](https://docs.aws.amazon.com/iotevents/latest/apireference/API_Payload.html). A separate column of
    /// the DynamoDB table receives one attribute-value pair in the payload that you
    /// specify. For more
    /// information, see
    /// [Actions](https://docs.aws.amazon.com/iotevents/latest/developerguide/iotevents-event-actions.html) in
    /// *AWS IoT Events Developer Guide*.
    dynamo_d_bv_2: ?DynamoDBv2Action = null,

    /// Sends information about the detector model instance and the event that
    /// triggered the
    /// action to an Amazon Kinesis Data Firehose delivery stream.
    firehose: ?FirehoseAction = null,

    /// Sends AWS IoT Events input, which passes information about the detector
    /// model instance and the
    /// event that triggered the action.
    iot_events: ?IotEventsAction = null,

    /// Sends information about the detector model instance and the event that
    /// triggered the
    /// action to an asset property in AWS IoT SiteWise .
    iot_site_wise: ?IotSiteWiseAction = null,

    /// Publishes an MQTT message with the given topic to the AWS IoT message
    /// broker.
    iot_topic_publish: ?IotTopicPublishAction = null,

    /// Calls a Lambda function, passing in information about the detector model
    /// instance and the
    /// event that triggered the action.
    lambda: ?LambdaAction = null,

    /// Information needed to reset the timer.
    reset_timer: ?ResetTimerAction = null,

    /// Information needed to set the timer.
    set_timer: ?SetTimerAction = null,

    /// Sets a variable to a specified value.
    set_variable: ?SetVariableAction = null,

    /// Sends an Amazon SNS message.
    sns: ?SNSTopicPublishAction = null,

    /// Sends information about the detector model instance and the event that
    /// triggered the
    /// action to an Amazon SQS queue.
    sqs: ?SqsAction = null,

    pub const json_field_names = .{
        .clear_timer = "clearTimer",
        .dynamo_db = "dynamoDB",
        .dynamo_d_bv_2 = "dynamoDBv2",
        .firehose = "firehose",
        .iot_events = "iotEvents",
        .iot_site_wise = "iotSiteWise",
        .iot_topic_publish = "iotTopicPublish",
        .lambda = "lambda",
        .reset_timer = "resetTimer",
        .set_timer = "setTimer",
        .set_variable = "setVariable",
        .sns = "sns",
        .sqs = "sqs",
    };
};
